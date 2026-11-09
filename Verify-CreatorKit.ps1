#requires -Version 7.4
# Read-only verification. Never extracts or executes archive contents.
param(
    [Parameter(Mandatory)][string]$Archive,
    [Parameter(Mandatory)][string]$Signature,
    [Parameter(Mandatory)][string]$PublicKey
)
$ErrorActionPreference='Stop'
# Trust anchor recorded independently of the downloaded archive/signature.
$expected='BE9B8A2479C3E54E54BC0D077AB21F5F133692713CA2EE5F45859F6346CD4868'
if((Get-Item -LiteralPath $PublicKey).Length -gt 512 -or (Get-Item -LiteralPath $Signature).Length -gt 2097152){throw 'Signature/key size limit.'}
$keyBytes=[IO.File]::ReadAllBytes([IO.Path]::GetFullPath($PublicKey))
if([Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($keyBytes)) -cne $expected){throw 'Official key fingerprint mismatch.'}
$envelope=Get-Content -LiteralPath $Signature -Raw -Encoding utf8 | ConvertFrom-Json -AsHashtable
if($envelope.Schema -ne 1 -or $envelope.Purpose -cne 'OfficialPackage' -or $envelope.Authority -cne 'desktopgadget.official' -or $envelope.KeyId -cne $expected){throw 'Unexpected signer or purpose.'}
$payload=[Convert]::FromBase64String($envelope.Payload)
$signatureBytes=[Convert]::FromBase64String($envelope.Signature)
if($payload.Length -lt 1 -or $payload.Length -gt 1048576 -or $signatureBytes.Length -ne 64){throw 'Signature document size limit.'}
$message=[Text.Encoding]::UTF8.GetBytes("DesktopGadget.signed-document.v1`ndesktopgadget.official`nOfficialPackage`n"+$expected+"`n"+[Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($payload)))
$key=[Security.Cryptography.ECDsa]::Create()
try {
    $consumed=0
    $key.ImportSubjectPublicKeyInfo($keyBytes,[ref]$consumed)
    if($consumed -ne $keyBytes.Length -or $key.ExportParameters($false).Curve.Oid.Value -cne '1.2.840.10045.3.1.7'){throw 'Unexpected official key format.'}
    if(-not $key.VerifyData($message,$signatureBytes,[Security.Cryptography.HashAlgorithmName]::SHA256,[Security.Cryptography.DSASignatureFormat]::IeeeP1363FixedFieldConcatenation)){throw 'Signature verification failed.'}
} finally {$key.Dispose()}
$release=[Text.Encoding]::UTF8.GetString($payload) | ConvertFrom-Json -AsHashtable
if($release.Schema -ne 1 -or $release.Profile -cne 'DesktopGadget.CreatorKit.v1' -or $release.Product -cne 'desktopgadget.creator-kit' -or $release.Platform -cne 'win-x64' -or $release.Version -cnotmatch '^[0-9]+\.[0-9]+\.[0-9]+$'){throw 'This is not a Creator Kit signature.'}
$name='DesktopGadget-'+$release.Version+'-CreatorKit-win-x64.zip'
if($release.FileName -cne $name -or [IO.Path]::GetFileName($Archive) -cne $name){throw 'Archive name does not match the signed release.'}
$stream=[IO.File]::Open([IO.Path]::GetFullPath($Archive),[IO.FileMode]::Open,[IO.FileAccess]::Read,[IO.FileShare]::Read)
try {
    if($stream.Length -lt 1 -or $stream.Length -gt 67108864 -or $stream.Length -ne $release.Bytes){throw 'Archive size mismatch.'}
    if([Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($stream)) -cne $release.Sha256){throw 'Archive hash mismatch.'}
    $stream.Position=0
    $zip=[IO.Compression.ZipArchive]::new($stream,[IO.Compression.ZipArchiveMode]::Read,$true)
    try {
        if($zip.Entries.Count -ne $release.FileCount -or $zip.Entries.Count -gt 1024){throw 'Archive file count mismatch.'}
        $names=[Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
        $total=0L
        foreach($entry in $zip.Entries){
            $n=$entry.FullName
            if(-not $names.Add($n) -or $n.StartsWith('/') -or $n.Contains('\') -or $n.Contains(':') -or $n.Split('/') -contains '..' -or $n.EndsWith('/') -or (($entry.ExternalAttributes -shr 16) -band 61440) -eq 40960){throw 'Invalid archive file name or type.'}
            $total+=$entry.Length
        }
        if($total -gt 67108864){throw 'Expanded size limit.'}
        $manifestEntry=$zip.GetEntry('file-manifest.json')
        if($null -eq $manifestEntry -or $manifestEntry.Length -gt 1048576){throw 'Missing or oversized inventory.'}
        $inputStream=$manifestEntry.Open()
        try {$buffer=[IO.MemoryStream]::new();$inputStream.CopyTo($buffer);$inventoryBytes=$buffer.ToArray();$buffer.Dispose()} finally {$inputStream.Dispose()}
        if([Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($inventoryBytes)) -cne $release.InventorySha256){throw 'Signed inventory mismatch.'}
        $inventory=[Text.Encoding]::UTF8.GetString($inventoryBytes) | ConvertFrom-Json -AsHashtable
        if($inventory.schema -cne 'desktopgadget.public-kit.inventory.v1' -or $inventory.version -cne $release.Version -or $inventory.files.Count+1 -ne $zip.Entries.Count){throw 'Unexpected inventory.'}
        $listed=[Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
        foreach($row in $inventory.files){
            if($row.path -ceq 'file-manifest.json' -or -not $listed.Add($row.path)){throw 'Duplicate inventory entry.'}
            $entry=$zip.GetEntry($row.path)
            if($null -eq $entry -or $entry.Length -ne $row.bytes){throw 'Missing or changed file.'}
            $inputStream=$entry.Open()
            try {$hash=[Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($inputStream))} finally {$inputStream.Dispose()}
            if($hash -cne $row.sha256){throw 'File hash mismatch.'}
        }
    } finally {$zip.Dispose()}
} finally {$stream.Dispose()}
@{status='PASS';version=$release.Version;files=$release.FileCount;sha256=$release.Sha256;officialSignatureVerified=$true;allFileHashesVerified=$true;archiveExtracted=$false;codeExecuted=$false;authenticodeSigned=$false;publicationAuthorized=$false;revocationChecked=$false} | ConvertTo-Json

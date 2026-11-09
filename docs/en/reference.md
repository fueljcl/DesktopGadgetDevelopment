# Short add-on reference

For version 1.3.4. This describes the formats used by the included examples, not promised future features.

## Entry and kinds

The C# entry is `public static string Run(string input)`. Input and output are strings.

| Kind | Output | Example |
|---|---|---|
| Plugin | Text matching the selected output kind | [hello](../../samples/hello/HelloPlugin.cs) |
| Provider | JSON containing values | [provider-renderer](../../samples/provider-renderer/README.md) |
| Renderer | JSON describing a drawing or HTML display | [html](../../samples/html/README.md) |

JSON names are case-sensitive. Ordinary input is limited to 16,384 characters. Reduce or split larger inputs.

## Provider values

Return JSON accepted by `PluginOutputCodec.ReadProvider`: at most 65,536 UTF-8 bytes, `Schema=1`, and 1–64 `Values`.

```json
{"Schema":1,"Values":[{"Field":"demo.value","Label":"Demo input","Value":37,"Unit":"%","Quality":"Valid","Reason":null}]}
```

`Field` is a unique identifier; `Label` allows 128 characters and `Unit` 32. Identifiers use 1–128 ASCII letters, digits or `._-:`. `Quality` is `Valid`, `Unknown`, `Stale` or `Unavailable`. Valid values must be finite numbers. Other qualities require a null value and a reason of at most 256 characters. Do not replace missing values with zero.

## Drawings

Return JSON accepted by `PluginOutputCodec.ReadScene`, with `Schema=1`, `Width`, `Height`, `Label`, `Description` and `Elements`.

There may be up to 128 elements. `Kind` is `line`, `circle`, `rect` or `text`; `X`,`Y` set position and `Color` uses `#RRGGBB`. `A`,`B` describe the line endpoint, circle radius (A), or rectangle width and height. `Size` sets line width or text size; `Text` holds display text. View dimensions must be positive and no greater than 8,192. The JSON limit is 65,536 bytes. Text limits are 1,024 characters per element and 4,096 total. Numbers must be finite. Start from the working sample.

## HTML

Use `PluginHtmlDocument` and `PluginHtmlCodec.Read`, with `Schema=1`, `Format="html"`, and `Entry="assets/index.html"`. Bundle the referenced HTML and JS. Width must be 120–2,048; height 60–2,048; label at most 128 characters; `Data` at most 8,192 characters. The JSON limit is 65,536 bytes.

JS receives data through the `chrome.webview` message event. Display strings with `textContent`. Direct access to external sites or local files is blocked. WebView2 Runtime is required. Sign the work again after changing HTML or JS.

## Approved file or HTTPS data

`PluginResources.Read` reads values the user selected and allowed. Declare each resource's `Id`, `Operation` and purpose first. Up to four resources are supported: `file.text`, `file.length`, `https.text`. Do not put actual paths or URLs in the declaration.

The input has `Schema=1`, `Input` and `Resources`. Each resource has `Id`, `Operation`, `Text`. `Input` allows 4,096 characters; each text value allows 2,048 UTF-8 bytes. File length is a nonnegative integer string. Targets and approval must be selected again after restarting the PC.

## Bundled files

`PluginAssets.Read("message.txt")` reads an asset from the signed work, not arbitrary PC files. The additional assets/libraries are limited to 32 files, 8 MiB each and 32 MiB total. Asset names start with an ASCII letter or digit and use letters, digits or `._-`. The app rejects invalid names and unsupported dependencies during review.

## Manifest and schema

The [example manifest](../../schemas/example.manifest.json) and [schema](../../schemas/manifest.schema.json) describe the CLI `validate` input, not signed metadata or internal app storage. The schema helps editors. Use the actual tool as well to catch duplicate keys and overlapping required/optional capability lists. Declaring a capability does not grant access.

[Getting started](getting-started.md) · [Commands](cli.md) · [Contents](../../README.md)

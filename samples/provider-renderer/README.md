# 値を表示する / Display a value

アプリのコンパイル画面で `DemoProvider.cs`、`MetricRenderer.cs`、`SampleValues.cs` の3ファイルを選び、1つのDLLを作ります。同じDLLから、次の2作品を別の作品IDで署名・導入します。

Select all three C# files above in the app's compiler and build one DLL. Sign and install two works with separate package IDs:

| 種類 / Kind | 入口 / Entry |
|---|---|
| Provider | `DesktopGadget.SampleMultiSource.DemoProvider` |
| Renderer | `DesktopGadget.SampleMultiSource.MetricRenderer` |

Rendererの設定でこのProviderを選び、入力を `37` にします。両作品を確認して許可すると `Demo input: 37 %` と棒が表示されます。`missing` は欠測の例です。実センサーの値ではありません。

In Renderer settings select this Provider and enter `37`. Review and allow both works: the display shows `Demo input: 37 %` and a bar. Input `missing` shows unavailable data. These are synthetic values, not sensor readings.

外部ビルドは `.NET SDK` を用意して `dotnet build DesktopGadget.SampleMultiSource.csproj -c Release --configfile NuGet.Config`。出力は `bin/Release/net10.0/` です。
For an external build, install the .NET SDK and run that command. Output is in `bin/Release/net10.0/`.

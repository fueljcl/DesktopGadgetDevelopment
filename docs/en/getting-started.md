# Make your first add-on

Start with [HelloPlugin.cs](../../samples/hello/HelloPlugin.cs). It adds `Hello: ` before the input text.

1. Open the app's work-authoring screen and choose Plugin.
2. Select `HelloPlugin.cs` as the C# source, choose a new DLL destination and compile. The DLL holds the add-on's code.
3. Select entry `Example.HelloPlugin` and text output.
4. Set your publisher ID, package ID, version and Creator signing key. Do not use an official key or someone else's key.
5. Review the files and description, then sign and export to a new ZIP. A signature binds the author to the content.
6. Install the ZIP with its matching public key. Check the public-key fingerprint through a separate trusted channel as well.
7. Enter `World`, review the request and allow execution. The expected result is `Hello: World`.

Installation alone does not run the work. Use Stop to end execution. After a change, increase the version and review/sign again. Keep private keys outside sample folders and ZIPs, following the app's storage instructions.

## Next

Try the value-display or HTML examples in the [sample list](../../samples/README.md). A Provider returns values; a Renderer displays them. Their data formats must match.

The app provides a free Marketplace submission flow, but public availability will be announced separately. These documents and the CLI do not upload work automatically.

[Reference](reference.md) · [Check commands](cli.md) · [Contents](../../README.md)

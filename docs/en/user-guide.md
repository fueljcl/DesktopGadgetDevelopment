# Start and update

For DesktopGadget Free 1.3.5, released on November 9, 2026.

1. Get the general edition from the [official download page](https://desktopgadget.org/en/download/).
2. Extract the ZIP and open its Setup. Check the version and destination, then install.
3. Start the app and add a gadget. Review and allow any required connection or file access.
4. Open Help in the app for the HTML manual, with instructions and pictures for the selected language.

## Update

You can check for updates manually. Startup checks are optional and off by default. Checking does not install an update automatically. Use the official Setup to update. Back up important data first.

For a PC without a working connection, use another PC to download the application ZIP and the latest offline safety information. Transfer them by USB or another method, then select the safety JSON in Setup. It is valid for 30 days from issue. Get a fresh copy if it has expired. This expiry does not limit ordinary startup of installed local features.

## Get help

Report the error text, steps and app version on [Discord](https://discord.gg/9Pydmv4BKx), or use [email](mailto:desktopgadget.org@gmail.com) for private details. Do not send passwords or private keys. Diagnostic reports are not uploaded automatically.

The free Marketplace is available. Open Marketplace from Add-ons in Management. It reuses your connected account: select a work and press Install / update. First-time users need to register or connect an account. After adding a language pack, select the display language in settings, save and restart. Optional development support is accepted on the official donation page.

[Terms](usage-en.md) · [Data handling](data-handling-en.md) · [Contents](../../README.md)

## Improvements in 1.3.5

Show content only is now available for every gadget. Fixed borders and handles remaining in daily and weekly agendas depending on the order of settings. Added Transparent / Black text and Transparent / White text, bringing the total to six presets. Transparent themes keep Management in its default colors while blending gadgets into your wallpaper. Individual color and opacity settings take priority, and the last theme change can be undone.

Choose Show content only in Appearance or the context menu. This is independent of the transparent theme. Reset individual appearance overrides to let a customized gadget inherit the theme. Management keeps its default colors. Explicit F3, background-menu and opacity-slider changes take priority. Images and external HTML contents are not rewritten.

## Improvements in 1.3.4

Fixed a recovery-warning case where saving and shutdown had completed but exceeded the waiting budget. Protection for failed saves or incomplete shutdown remains, with local shutdown diagnostics for other cases. Light-theme inputs, status labels and selected rows are easier to read.

Calendar, daily agenda and weekly agenda gadgets now include an Import button. Use Import in the context menu in display-only mode, or Management when click-through is enabled. Import and Export on the right of the selected gadget in Management remain available.

## Sharing schedules and choosing colors

Select events or recurring series and export them to a file or a public/unlisted Marketplace link. Anyone with an unlisted link can retrieve its contents, including people it is forwarded to. A publisher can update the same URL; recipients retrieve it again and choose Replace, Keep both or Skip for duplicates. Nothing synchronizes automatically.

Sharing preserves recurrence end dates and count limits, plus single-occurrence and temporary changes. Preview start/end dates in the editor only choose occurrences to review; they do not define the recurrence period. Choose whether to apply notification and calendar settings when importing. Job definitions, execution permissions, paths and account details are not shared.

Management offers Classic, Light, Pink and Blue presets. Applying a preset to all gadgets preserves their individual settings, and the previous theme can be restored. Cursor effects have separate outer and inner opacity; setting a circle’s inner opacity to 0% leaves its center transparent.

## Changes in 1.2

Management now has four task-based pages with fewer repeated confirmations. Account entitlements refresh at startup, after reconnection and periodically; Marketplace shares the same connection. Setup runs the selected operation directly and shows the item being deleted and progress when cleaning up old versions.

This release improves cursor recovery after UAC, weekend and holiday colors, notification retention and display limits (1–100 each), and gadget height. Startup verifies runtime files before loading .NET.

Back up settings and agenda data before updating. Extract the complete official ZIP; do not mix partial files from different versions. If verification fails, extract the official ZIP to a new folder or use Setup repair. The settings format is 26. Back up the entire data folder before updating. Returning to 1.3.4 or earlier also requires restoring the settings backup made before this update.

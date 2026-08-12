# Meowsum

A macOS placeholder-text generator with a cat problem. Lorem ipsum, but every so often the Latin slips and it meows.

Meowsum is a native SwiftUI app that generates filler content — lorem ipsum, names, links, and dates — and puts it on your clipboard from wherever you happen to be working.

## Three ways to use it

- **Main window** — pick your options, preview the output, copy it.
- **Menu bar** — the scroll icon in the status bar copies common presets in two clicks, without leaving your current app.
- **Right-click → Services** — insert generated text straight into any editable text field, at the cursor, in any app.

## What it generates

| Generator | Options |
| --- | --- |
| Lorem ipsum | Paragraphs, sentences, words, titles, characters — with cat vocabulary spliced into the Latin |
| Names | First, middle, and last name combinations |
| Links | Plain URL or HTML `<a>` tag |
| Dates | US, UK, European, ISO 8601, long form, or relative — always a future date |

The window also has a light/dark/system theme toggle that persists between launches.

## Requirements

- macOS 13 (Ventura) or later
- Swift 5.9 or later (Xcode 15+)

## Install

```bash
git clone https://github.com/joshcoast/meowsum.git
cd meowsum
./install.sh
```

`install.sh` builds a release binary, generates the app icon, assembles `Meowsum.app`, ad-hoc signs it, installs it to `/Applications`, and registers the Services menu entries.

Because the app is ad-hoc signed rather than notarized, macOS will block it the first time. Right-click the app → **Open**, then click **Open** in the dialog. This is only needed once.

If the Services entries don't appear right away, log out and back in — macOS caches the Services list aggressively.

## Development

```bash
swift run                 # run the debug build
swift build -c release    # build the release binary only
```

Running the bare SwiftPM binary works, but the Services menu and the app icon only exist in the assembled bundle, so use `./install.sh` to test those.

## Project layout

```
Sources/Meowsum/
  MeowsumApp.swift     App entry point, window and menu bar scenes
  ContentView.swift    Main window layout and theming
  MenuBarView.swift    Menu bar extra
  Services.swift       System Services menu provider
  *Generator.swift     Generation logic (lorem, name, link, date)
  *View.swift          Per-generator UI sections
  Palette.swift        Colors
  Components.swift     Shared UI components
GenerateIcon.swift     Draws AppIcon.icns at build time
Resources/Info.plist   Bundle metadata and Services declarations
install.sh             Build, bundle, sign, install
```

`Services.swift` and `Resources/Info.plist` both describe the Services menu entries — if you add one, update both or the new entry won't appear.

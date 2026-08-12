#!/usr/bin/env bash
set -euo pipefail

APP_NAME="Meowsum"
RELEASE_BIN=".build/release/$APP_NAME"
APP_BUNDLE="${APP_NAME}.app"

echo "→ Building release binary…"
swift build -c release

echo "→ Generating app icon…"
swift GenerateIcon.swift

echo "→ Assembling ${APP_BUNDLE}…"
rm -rf "$APP_BUNDLE"
mkdir -p "$APP_BUNDLE/Contents/MacOS"
mkdir -p "$APP_BUNDLE/Contents/Resources"

cp "$RELEASE_BIN" "$APP_BUNDLE/Contents/MacOS/"
cp "AppIcon.icns"  "$APP_BUNDLE/Contents/Resources/"
rm -f "AppIcon.icns"

# Flatten the SwiftPM resource bundle into Contents/Resources. Shipping it as a nested
# .bundle fails codesign, since SwiftPM emits no Info.plist for it.
cp -R ".build/release/${APP_NAME}_${APP_NAME}.bundle/." "$APP_BUNDLE/Contents/Resources/"

cp "Resources/Info.plist" "$APP_BUNDLE/Contents/Info.plist"

echo "→ Ad-hoc signing…"
# Extended attributes copied along with the sources make codesign reject the bundle.
xattr -cr "$APP_BUNDLE"
# The SwiftPM resource bundle holds no code and no Info.plist, so codesign can't sign it as a
# nested bundle — it gets sealed as a plain resource of the app instead.
codesign --force --sign - "$APP_BUNDLE"

echo "→ Installing to /Applications…"
# Remove old version if present
rm -rf "/Applications/${APP_BUNDLE}"
cp -r "$APP_BUNDLE" /Applications/

echo "→ Registering Services…"
# macOS only offers the right-click Services once the app is registered and pbs re-reads it.
LSREGISTER="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister"
[ -x "$LSREGISTER" ] && "$LSREGISTER" -f "/Applications/${APP_BUNDLE}" || true
/System/Library/CoreServices/pbs -flush >/dev/null 2>&1 || true

echo ""
echo "✓ ${APP_NAME}.app installed to /Applications"
echo ""
echo "First launch: right-click the app → Open, then click Open in the dialog."
echo "(macOS blocks unsigned apps on first run — this bypasses Gatekeeper once.)"

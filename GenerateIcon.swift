#!/usr/bin/env swift  // GenerateIcon.swift — run with `swift GenerateIcon.swift` from the project root.
// Scales Resources/AppIcon.png down into an AppIcon.icns iconset.
import AppKit

// MARK: - Load source artwork

private let sourcePath = "Resources/AppIcon.png"

guard let sourceImage = NSImage(contentsOfFile: sourcePath),
	let sourceCG = sourceImage.cgImage(forProposedRect: nil, context: nil, hints: nil)
else {
	fputs("Could not load \(sourcePath)\n", stderr)
	exit(1)
}

// MARK: - Render a single size to PNG data

func renderPNG(size: Int) -> Data {
	let s = CGFloat(size)
	guard
		let ctx = CGContext(
			data: nil,
			width: size, height: size,
			bitsPerComponent: 8, bytesPerRow: 0,
			space: CGColorSpaceCreateDeviceRGB(),
			bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
		)
	else {
		fatalError("Could not create bitmap context for \(size)px")
	}

	ctx.interpolationQuality = .high
	let rect = CGRect(x: 0, y: 0, width: s, height: s)
	// Source art is a hard-edged square; mask to the macOS icon corner radius.
	ctx.addPath(
		CGPath(roundedRect: rect, cornerWidth: s * 0.2237, cornerHeight: s * 0.2237, transform: nil)
	)
	ctx.clip()
	ctx.draw(sourceCG, in: rect)

	guard let cgImage = ctx.makeImage() else {
		fatalError("Could not create image for \(size)px")
	}
	guard let png = NSBitmapImageRep(cgImage: cgImage).representation(using: .png, properties: [:])
	else {
		fatalError("Could not encode PNG for \(size)px")
	}
	return png
}

// MARK: - Write iconset and convert to .icns

let fm = FileManager.default
let iconset = "AppIcon.iconset"

try? fm.removeItem(atPath: iconset)
try fm.createDirectory(atPath: iconset, withIntermediateDirectories: true)

let sizes: [(String, Int)] = [
	("icon_16x16.png", 16), ("icon_16x16@2x.png", 32),
	("icon_32x32.png", 32), ("icon_32x32@2x.png", 64),
	("icon_128x128.png", 128), ("icon_128x128@2x.png", 256),
	("icon_256x256.png", 256), ("icon_256x256@2x.png", 512),
	("icon_512x512.png", 512), ("icon_512x512@2x.png", 1024),
]

for (name, px) in sizes {
	print("  Rendering \(name) (\(px)px)…")
	let data = renderPNG(size: px)
	try data.write(to: URL(fileURLWithPath: "\(iconset)/\(name)"))
}

let proc = Process()
proc.executableURL = URL(fileURLWithPath: "/usr/bin/iconutil")
proc.arguments = ["-c", "icns", "-o", "AppIcon.icns", iconset]
try proc.run()
proc.waitUntilExit()
try? fm.removeItem(atPath: iconset)

guard proc.terminationStatus == 0 else {
	fputs("iconutil failed with status \(proc.terminationStatus)\n", stderr)
	exit(1)
}
print("  ✓ AppIcon.icns written")

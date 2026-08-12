import AppKit
import SwiftUI

struct AppIconView: View {
	var size: CGFloat = 80

	@Environment(\.colorScheme) private var colorScheme

	private var ink: Color { Palette.accent(colorScheme) }

	var body: some View {
		Image(nsImage: AppIconView.glyph)
			.resizable()
			.renderingMode(.template)
			.interpolation(.high)
			.scaledToFit()
			.foregroundStyle(ink)
			.frame(width: size, height: size)
	}

	private static let glyph: NSImage = {
		// Installed app keeps resources in Contents/Resources; dev runs read the SwiftPM bundle.
		let url =
			Bundle.main.url(forResource: "AppIconGlyph", withExtension: "png")
			?? Bundle.module.url(forResource: "AppIconGlyph", withExtension: "png")
		guard let url, let image = NSImage(contentsOf: url)
		else {
			assertionFailure("AppIconGlyph.png missing from the resource bundle")
			return NSImage(size: .zero)
		}
		image.isTemplate = true
		return image
	}()
}

#Preview {
	AppIconView(size: 140)
		.padding(40)
		.background(Palette.ink)
}

import SwiftUI

/// Colors sampled from the poster art: ink black, coral, lime, cream.
enum Palette {
	static let coral = Color(red: 0.91, green: 0.34, blue: 0.29)
	static let coralDeep = Color(red: 0.78, green: 0.24, blue: 0.19)
	static let lime = Color(red: 0.68, green: 0.76, blue: 0.16)
	static let limeDeep = Color(red: 0.47, green: 0.54, blue: 0.09)
	static let cream = Color(red: 0.94, green: 0.89, blue: 0.78)
	static let ink = Color(red: 0.07, green: 0.06, blue: 0.06)

	/// Accent used for the header art and prominent controls.
	static func accent(_ scheme: ColorScheme) -> Color {
		scheme == .dark ? coral : coralDeep
	}

	static func windowBackground(_ scheme: ColorScheme) -> Color {
		scheme == .dark ? ink : cream
	}

	static func cardBackground(_ scheme: ColorScheme) -> Color {
		scheme == .dark
			? Color(red: 0.13, green: 0.12, blue: 0.11)
			: Color(red: 0.98, green: 0.96, blue: 0.90)
	}

	static func fieldBackground(_ scheme: ColorScheme) -> Color {
		scheme == .dark
			? Color(red: 0.10, green: 0.09, blue: 0.08)
			: Color(red: 1.00, green: 0.99, blue: 0.95)
	}

	static func border(_ scheme: ColorScheme) -> Color {
		scheme == .dark ? coral.opacity(0.28) : ink.opacity(0.14)
	}

	static func primaryText(_ scheme: ColorScheme) -> Color {
		scheme == .dark ? cream : ink
	}

	/// Chartreuse tagline, echoing the poster's lime lettering. Same in both themes.
	static let subtitle = Color(red: 0.635, green: 0.678, blue: 0.086)

	static func success(_ scheme: ColorScheme) -> Color {
		scheme == .dark ? lime : limeDeep
	}
}

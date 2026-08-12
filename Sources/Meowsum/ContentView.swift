import SwiftUI

enum AppTheme: String, CaseIterable {
	case system = "System"
	case light = "Light"
	case dark = "Dark"

	var colorScheme: ColorScheme? {
		switch self {
		case .system: return nil
		case .light: return .light
		case .dark: return .dark
		}
	}

	var icon: String {
		switch self {
		case .system: return "circle.lefthalf.filled"
		case .light: return "sun.max"
		case .dark: return "moon.stars"
		}
	}

	var next: AppTheme {
		let all = AppTheme.allCases
		let idx = (all.firstIndex(of: self)! + 1) % all.count
		return all[idx]
	}
}

struct ContentView: View {
	@AppStorage("appTheme") private var theme: AppTheme = .dark
	@Environment(\.colorScheme) private var colorScheme

	var body: some View {
		ScrollView(.vertical) {
			VStack(spacing: 12) {

				// ── Header ─────────────────────────────────────────────
				VStack(spacing: 6) {
					AppIconView(size: 132)
					Text("Loremeow Sum Generator")
						.font(.system(size: 10, weight: .semibold))
						.foregroundStyle(Palette.subtitle)
						.tracking(2.5)
						.textCase(.uppercase)
				}
				.padding(.top, 8)
				.padding(.bottom, 4)

				LoremView()
				NameView()
				LinkView()
				DateView()
			}
			.padding(20)
		}
		.frame(minWidth: 520, minHeight: 560)
		.background(Palette.windowBackground(colorScheme))
		.tint(Palette.accent(colorScheme))
		.preferredColorScheme(theme.colorScheme)
		.toolbar {
			ToolbarItem(placement: .automatic) {
				Button {
					theme = theme.next
				} label: {
					Label(theme.next.rawValue, systemImage: theme.icon)
						.help("Switch to \(theme.next.rawValue) theme")
				}
				.buttonStyle(.borderless)
				.padding(6)
				.contentShape(Rectangle())
			}
		}
	}
}

#Preview {
	ContentView()
		.frame(width: 600, height: 800)
}

import AppKit
import SwiftUI

struct MenuBarView: View {
	@AppStorage("appTheme") private var theme: AppTheme = .dark
	@Environment(\.openWindow) private var openWindow

	var body: some View {
		// ── Lorem ─────────────────────────────────────────────────────
		Menu("Lorem Ipsum") {
			Button("1 Paragraph") { copy(LoremGenerator.generate(count: 1, type: .paragraphs)) }
			Button("3 Paragraphs") { copy(LoremGenerator.generate(count: 3, type: .paragraphs)) }
			Button("5 Paragraphs") { copy(LoremGenerator.generate(count: 5, type: .paragraphs)) }
			Divider()
			Button("1 Sentence") { copy(LoremGenerator.generate(count: 1, type: .sentences)) }
			Button("3 Sentences") { copy(LoremGenerator.generate(count: 3, type: .sentences)) }
			Divider()
			Button("5 Words") { copy(LoremGenerator.generate(count: 5, type: .words)) }
			Button("10 Words") { copy(LoremGenerator.generate(count: 10, type: .words)) }
			Divider()
			Button("5-Word Title") { copy(LoremGenerator.generate(count: 5, type: .title)) }
			Button("8-Word Title") { copy(LoremGenerator.generate(count: 8, type: .title)) }
		}

		// ── Name ──────────────────────────────────────────────────────
		Button("Random Name") {
			copy(NameGenerator.generate())
		}

		// ── Link ──────────────────────────────────────────────────────
		Menu("Random Link") {
			Button("Plain URL") {
				copy(LinkGenerator.generate(asHTML: false))
			}
			Button("HTML <a> Tag") {
				copy(LinkGenerator.generate(asHTML: true))
			}
		}

		// ── Date ──────────────────────────────────────────────────────
		Menu("Random Date") {
			ForEach(DateLocale.allCases) { locale in
				Button(locale.rawValue) {
					copy(DateGenerator.generate(locale: locale))
				}
			}
		}

		Divider()

		// ── Theme ─────────────────────────────────────────────────────
		Menu("Theme") {
			ForEach(AppTheme.allCases, id: \.rawValue) { t in
				Button {
					theme = t
				} label: {
					Label(
						t.rawValue,
						systemImage: t == theme ? "checkmark" : t.icon
					)
				}
			}
		}

		Divider()

		// ── Open main window ──────────────────────────────────────────
		Button("Open Meowsum…") {
			NSApp.activate(ignoringOtherApps: true)
			openWindow(id: MeowsumApp.mainWindowID)
		}
		.keyboardShortcut("o", modifiers: [.command])

		Button("Quit Meowsum") {
			NSApp.terminate(nil)
		}
		.keyboardShortcut("q", modifiers: [.command])
	}

	private func copy(_ text: String) {
		NSPasteboard.general.clearContents()
		NSPasteboard.general.setString(text, forType: .string)
	}
}

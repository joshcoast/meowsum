import AppKit
import SwiftUI

// MARK: - SectionCard

struct SectionCard<Content: View>: View {
	let title: String
	let icon: String
	@Environment(\.colorScheme) private var colorScheme
	@ViewBuilder let content: () -> Content

	var body: some View {
		VStack(alignment: .leading, spacing: 14) {
			Label(title, systemImage: icon)
				.font(.system(size: 14, weight: .semibold))
				.foregroundStyle(Palette.primaryText(colorScheme))

			content()
		}
		.padding(16)
		.frame(maxWidth: .infinity, alignment: .leading)
		.background(
			RoundedRectangle(cornerRadius: 12)
				.fill(Palette.cardBackground(colorScheme))
		)
		.overlay(
			RoundedRectangle(cornerRadius: 12)
				.strokeBorder(Palette.border(colorScheme), lineWidth: 1)
		)
	}
}

// MARK: - OutputField

struct OutputField: View {
	let text: String
	var maxHeight: CGFloat = 220
	@State private var copied = false
	@State private var copyCount = 0
	@Environment(\.colorScheme) private var colorScheme

	var body: some View {
		VStack(alignment: .trailing, spacing: 6) {
			ScrollView(.vertical) {
				Text(text)
					.font(.system(.callout, design: .monospaced))
					.lineSpacing(3)
					.foregroundStyle(Palette.primaryText(colorScheme))
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding(10)
					.textSelection(.enabled)
			}
			.frame(minHeight: 48, maxHeight: maxHeight)
			.background(Palette.fieldBackground(colorScheme))
			.clipShape(RoundedRectangle(cornerRadius: 8))
			.overlay(
				RoundedRectangle(cornerRadius: 8)
					.strokeBorder(Palette.border(colorScheme), lineWidth: 1)
			)

			Button(action: copyText) {
				Label(
					copied ? "Copied" : "Copy",
					systemImage: copied ? "checkmark.circle.fill" : "doc.on.doc"
				)
				.font(.system(size: 12, weight: .medium))
				.animation(.easeInOut(duration: 0.15), value: copied)
			}
			.buttonStyle(.borderless)
			.foregroundStyle(copied ? Palette.success(colorScheme) : Palette.accent(colorScheme))
		}
		// Keyed on copyCount so a repeat copy restarts the window instead of inheriting the old timer.
		.task(id: copyCount) {
			guard copyCount > 0 else { return }
			try? await Task.sleep(for: .seconds(2))
			guard !Task.isCancelled else { return }
			withAnimation { copied = false }
		}
	}

	private func copyText() {
		NSPasteboard.general.clearContents()
		NSPasteboard.general.setString(text, forType: .string)
		withAnimation { copied = true }
		copyCount += 1
	}
}

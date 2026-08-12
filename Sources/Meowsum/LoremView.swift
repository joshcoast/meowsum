import SwiftUI

struct LoremView: View {
	@State private var amountText: String = "3"
	@State private var contentType: ContentType = .paragraphs
	@State private var output: String = ""
	@FocusState private var amountFocused: Bool

	private static let maxAmount = 500

	// Text is the source of truth while editing so the value commits on every keystroke,
	// not just on Enter — macOS buttons don't take focus, so clicking Generate wouldn't commit.
	private var count: Int {
		min(max(Int(amountText) ?? 1, 1), Self.maxAmount)
	}

	private var countBinding: Binding<Int> {
		Binding(get: { count }, set: { amountText = String($0) })
	}

	var body: some View {
		SectionCard(title: "Lorem Ipsum", icon: "text.alignleft") {
			HStack(spacing: 12) {
				// Amount
				VStack(alignment: .leading, spacing: 3) {
					Text("Amount")
						.font(.caption)
						.foregroundColor(.secondary)
					HStack(spacing: 4) {
						TextField("", text: $amountText)
							.textFieldStyle(.roundedBorder)
							.frame(width: 54)
							.focused($amountFocused)
							.onChange(of: amountText) { newValue in
								let digits = String(newValue.filter(\.isNumber).prefix(3))
								if digits != newValue { amountText = digits }
							}
							.onChange(of: amountFocused) { focused in
								if !focused { amountText = String(count) }
							}
							.onSubmit { amountText = String(count) }
						Stepper("", value: countBinding, in: 1...Self.maxAmount)
							.labelsHidden()
					}
				}

				// Type
				VStack(alignment: .leading, spacing: 3) {
					Text("Type")
						.font(.caption)
						.foregroundColor(.secondary)
					Picker("", selection: $contentType) {
						ForEach(ContentType.allCases) { type in
							Text(type.rawValue).tag(type)
						}
					}
					.pickerStyle(.menu)
					.labelsHidden()
					.frame(width: 130)
				}

				Spacer()

				Button(action: generate) {
					Label("Generate", systemImage: "wand.and.stars")
				}
				.buttonStyle(.borderedProminent)
			}

			if !output.isEmpty {
				OutputField(text: output, maxHeight: 280)
			}
		}
	}

	private func generate() {
		// Clicking a button doesn't blur the field, so normalize the display here too.
		amountText = String(count)
		output = LoremGenerator.generate(count: count, type: contentType)
	}
}

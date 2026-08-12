import SwiftUI

struct DateView: View {
    @State private var dateLocale: DateLocale = .unitedStates
    @State private var output: String = ""

    var body: some View {
        SectionCard(title: "Date", icon: "calendar") {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 3) {
                    Text("Format")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Picker("", selection: $dateLocale) {
                        ForEach(DateLocale.allCases) { locale in
                            Text(locale.rawValue).tag(locale)
                        }
                    }
                    .pickerStyle(.menu)
                    .labelsHidden()
                    .frame(width: 160)
                }

                Spacer()

                Button(action: generate) {
                    Label("Generate", systemImage: "wand.and.stars")
                }
                .buttonStyle(.borderedProminent)
            }

            if !output.isEmpty {
                OutputField(text: output, maxHeight: 60)
            }
        }
    }

    private func generate() {
        output = DateGenerator.generate(locale: dateLocale)
    }
}

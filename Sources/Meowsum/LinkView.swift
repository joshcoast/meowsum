import SwiftUI

struct LinkView: View {
    @State private var asHTML = false
    @State private var output: String = ""

    var body: some View {
        SectionCard(title: "Link", icon: "link") {
            HStack(spacing: 16) {
                Toggle("Wrap in HTML <a> tag", isOn: $asHTML)
                    .toggleStyle(.checkbox)
                    .font(.callout)
                Spacer()
                Button(action: generate) {
                    Label("Generate", systemImage: "wand.and.stars")
                }
                .buttonStyle(.borderedProminent)
            }

            if !output.isEmpty {
                OutputField(text: output, maxHeight: 80)
            }
        }
    }

    private func generate() {
        output = LinkGenerator.generate(asHTML: asHTML)
    }
}

import SwiftUI

struct NameView: View {
    @State private var output: String = ""

    var body: some View {
        SectionCard(title: "Name", icon: "person") {
            HStack {
                Text("First · Middle · Last")
                    .font(.callout)
                    .foregroundColor(.secondary)
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
        output = NameGenerator.generate()
    }
}

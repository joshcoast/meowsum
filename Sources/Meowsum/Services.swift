import AppKit

/// One entry in the right-click Services menu.
/// The raw value is the `NSUserData` string in Info.plist, so the two must stay in sync.
enum GeneratorOption: String, CaseIterable {
	case paragraph1 = "paragraphs:1"
	case paragraph3 = "paragraphs:3"
	case paragraph5 = "paragraphs:5"
	case sentence1 = "sentences:1"
	case sentence3 = "sentences:3"
	case words5 = "words:5"
	case words10 = "words:10"
	case title5 = "title:5"
	case name = "name"
	case link = "link"
	case linkHTML = "link:html"
	case date = "date"

	/// Must match the Info.plist NSMenuItem text for this option.
	var title: String {
		switch self {
		case .paragraph1: return "1 Paragraph"
		case .paragraph3: return "3 Paragraphs"
		case .paragraph5: return "5 Paragraphs"
		case .sentence1: return "1 Sentence"
		case .sentence3: return "3 Sentences"
		case .words5: return "5 Words"
		case .words10: return "10 Words"
		case .title5: return "5-Word Title"
		case .name: return "Random Name"
		case .link: return "Random Link"
		case .linkHTML: return "Random Link (HTML)"
		case .date: return "Random Date"
		}
	}

	func generate() -> String {
		switch self {
		case .paragraph1: return LoremGenerator.generate(count: 1, type: .paragraphs)
		case .paragraph3: return LoremGenerator.generate(count: 3, type: .paragraphs)
		case .paragraph5: return LoremGenerator.generate(count: 5, type: .paragraphs)
		case .sentence1: return LoremGenerator.generate(count: 1, type: .sentences)
		case .sentence3: return LoremGenerator.generate(count: 3, type: .sentences)
		case .words5: return LoremGenerator.generate(count: 5, type: .words)
		case .words10: return LoremGenerator.generate(count: 10, type: .words)
		case .title5: return LoremGenerator.generate(count: 5, type: .title)
		case .name: return NameGenerator.generate()
		case .link: return LinkGenerator.generate(asHTML: false)
		case .linkHTML: return LinkGenerator.generate(asHTML: true)
		case .date: return DateGenerator.generate()
		}
	}
}

/// Backs the system Services menu. Declaring only NSReturnTypes (no send types) means these
/// appear for any editable text field and insert at the cursor without needing a selection.
final class ServiceProvider: NSObject {
	@objc func generateText(
		_ pasteboard: NSPasteboard,
		userData: String?,
		error: AutoreleasingUnsafeMutablePointer<NSString?>
	) {
		guard let userData, let option = GeneratorOption(rawValue: userData) else {
			error.pointee = "Meowsum: unknown service option \(userData ?? "(none)")" as NSString
			return
		}
		pasteboard.clearContents()
		pasteboard.setString(option.generate(), forType: .string)
	}
}

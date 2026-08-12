import Foundation

enum ContentType: String, CaseIterable, Identifiable {
	case paragraphs = "Paragraphs"
	case sentences = "Sentences"
	case words = "Words"
	case title = "Title"
	case characters = "Characters"

	var id: String { rawValue }
}

struct LoremGenerator {
	// Extended word pool drawn from classic lorem ipsum and Cicero's de Finibus Bonorum et Malorum
	static let words: [String] = [
		"lorem", "ipsum", "dolor", "sit", "amet", "consectetur",
		"adipiscing", "elit", "sed", "eiusmod", "tempor", "incididunt",
		"labore", "dolore", "magna", "aliqua", "enim", "minim",
		"veniam", "quis", "nostrud", "exercitation", "ullamco", "laboris",
		"nisi", "aliquip", "commodo", "consequat", "duis", "aute", "irure",
		"reprehenderit", "voluptate", "velit", "esse", "cillum", "fugiat",
		"nulla", "pariatur", "excepteur", "sint", "occaecat", "cupidatat",
		"proident", "culpa", "officia", "deserunt", "mollit", "anim", "laborum",
		"perspiciatis", "unde", "omnis", "iste", "natus", "error",
		"voluptatem", "accusantium", "doloremque", "laudantium", "totam",
		"aperiam", "eaque", "ipsa", "quae", "illo", "inventore",
		"veritatis", "quasi", "architecto", "beatae", "vitae", "dicta",
		"explicabo", "nemo", "ipsam", "quia", "voluptas", "aspernatur",
		"odit", "consequuntur", "magni", "dolores", "ratione", "sequi",
		"nesciunt", "neque", "porro", "quisquam", "adipisci", "numquam",
		"modi", "tempora", "incidunt", "magnam", "quaerat",
		"pellentesque", "habitant", "morbi", "tristique", "senectus",
		"netus", "malesuada", "fames", "turpis", "egestas", "volutpat",
		"auctor", "augue", "mauris", "gravida", "fermentum", "posuere",
		"urna", "tincidunt", "praesent", "semper", "feugiat", "nibh",
		"pulvinar", "proin", "sagittis", "nisl", "rhoncus", "mattis",
		"viverra", "justo", "ultrices", "sapien", "eget", "libero",
		"faucibus", "bibendum", "congue", "quisque", "arcu", "cursus",
		"euismod", "blandit", "ornare", "vivamus", "felis", "suspendisse",
		"risus", "maecenas", "accumsan", "lacus", "facilisis", "venenatis",
		"condimentum", "aenean", "pharetra", "vehicula", "elementum",
		"scelerisque", "inceptos", "himenaeos", "eleifend", "porttitor",
		"luctus", "tortor", "iaculis", "aliquam", "erat",
		"odio", "facilisi", "fringilla", "interdum", "metus",
		"sollicitudin", "lectus", "quam", "hendrerit", "diam", "vulputate",
		"varius", "rutrum", "taciti", "sociosqu", "litora", "torquent",
		"conubia", "nostra", "dictum", "fusce", "tellus",
		"nullam", "placerat", "ante", "donec", "pretium", "dapibus",
		"dignissim", "lobortis", "laoreet", "lacinia",
	]

	// Spliced into the latin at random so output stays lorem-ish but occasionally meows.
	static let catWords: [String] = [
		"meow", "purr", "hiss", "scratch", "nap", "whiskers", "paws", "floof",
		"zoomies", "catnip", "kibble", "tuna", "yarn", "kitten", "tabby",
		"claws", "tail", "pounce", "prowl", "knead", "chirp", "trill", "yowl",
		"mrrp", "blep", "mlem", "toebeans", "catloaf", "sploot", "boop",
		"headbutt", "biscuits", "hairball", "sunbeam", "windowsill",
		"cardboard", "snuggle", "nibble", "skritch", "purrito", "murp",
		// Latin-flavoured puns that blend with the surrounding lorem
		"loremeow", "meowsum", "purrsum", "catsectetur", "purrspiciatis",
		"felinius", "purrgatorium", "clawdius", "meowgna", "dolormeow",
		"whiskerum", "pawsum", "nappitur", "purrvenire", "catus",
		// Phrases
		"here kitty kitty", "pspspsps", "feed me", "make biscuits",
		"attack the ankles", "sit on the keyboard", "knock it off the table",
		"three am zoomies", "judgemental stare", "nap in the sunbeam",
	]

	private static let catWordChance = 0.12

	static func randomWord() -> String {
		Double.random(in: 0..<1) < catWordChance
			? catWords.randomElement()!
			: words.randomElement()!
	}

	static func generate(count: Int, type: ContentType) -> String {
		let n = max(1, count)
		switch type {
		case .paragraphs:
			return (0..<n).map { _ in paragraph() }.joined(separator: "\n\n")
		case .sentences:
			return (0..<n).map { _ in sentence() }.joined(separator: " ")
		case .words:
			return (0..<n).map { _ in randomWord() }.joined(separator: " ")
		case .title:
			return (0..<n).map { _ in randomWord().capitalized }.joined(separator: " ")
		case .characters:
			var result = ""
			while result.count < n {
				if !result.isEmpty { result += " " }
				result += randomWord()
			}
			var trimmed = String(result.prefix(n))
			while trimmed.hasSuffix(" ") { trimmed.removeLast() }
			return trimmed
		}
	}

	// Only the first character, so multi-word cat phrases don't become Title Case mid-sentence.
	private static func sentenceCased(_ word: String) -> String {
		guard let first = word.first else { return word }
		return first.uppercased() + word.dropFirst()
	}

	// A single sentence: 7–18 words, capitalised first word, period at end.
	static func sentence() -> String {
		let count = Int.random(in: 7...18)
		var w = (0..<count).map { _ in randomWord() }
		w[0] = sentenceCased(w[0])
		return w.joined(separator: " ") + "."
	}

	// A paragraph of 3–7 sentences, each a different random length.
	private static func paragraph() -> String {
		let n = Int.random(in: 3...7)
		return (0..<n).map { _ in sentence() }.joined(separator: " ")
	}
}

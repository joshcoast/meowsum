// swift-tools-version: 5.9
import PackageDescription

let package = Package(
	name: "Meowsum",
	platforms: [.macOS(.v13)],
	targets: [
		.executableTarget(
			name: "Meowsum",
			path: "Sources/Meowsum",
			resources: [.process("Resources")],
			linkerSettings: [
				// Gives the process a bundle identifier when Xcode runs the bare
				// binary instead of Meowsum.app, silencing linkd/Intents registration errors.
				.unsafeFlags([
					"-Xlinker", "-sectcreate",
					"-Xlinker", "__TEXT",
					"-Xlinker", "__info_plist",
					"-Xlinker", "Resources/Info.plist",
				])
			]
		)
	]
)

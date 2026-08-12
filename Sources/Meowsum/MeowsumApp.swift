import AppKit
import SwiftUI

// An unbundled SwiftPM binary launches as a background process and can never become the
// active app, so keystrokes go to whatever was frontmost. Promoting it here makes
// running straight from Xcode behave like the packaged Meowsum.app.
private final class AppDelegate: NSObject, NSApplicationDelegate {
	// Held here because NSApp.servicesProvider is a weak reference.
	private let serviceProvider = ServiceProvider()

	func applicationDidFinishLaunching(_ notification: Notification) {
		NSApp.setActivationPolicy(.regular)
		NSApp.activate(ignoringOtherApps: true)

		NSApp.servicesProvider = serviceProvider
		NSUpdateDynamicServices()
	}
}

@main
struct MeowsumApp: App {
	@NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

	var body: some Scene {
		// A single Window (not WindowGroup) so the menu bar item can reopen this exact window.
		Window("Meowsum", id: MeowsumApp.mainWindowID) {
			ContentView()
		}
		.defaultSize(width: 600, height: 800)
		.windowResizability(.contentMinSize)

		MenuBarExtra {
			MenuBarView()
		} label: {
			Image(systemName: "scroll")
		}
		.menuBarExtraStyle(.menu)
	}

	static let mainWindowID = "main"
}

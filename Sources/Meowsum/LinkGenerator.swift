import Foundation

struct LinkGenerator {
    static let paths: [String] = [
        "dashboard", "profile", "settings", "about", "contact",
        "home", "services", "products", "blog", "news",
        "events", "gallery", "portfolio", "careers", "support",
        "privacy", "terms", "login", "register", "checkout",
        "account", "orders", "notifications", "search", "help",
        "docs", "api", "status", "pricing", "features",
        "download", "upload", "share", "report", "feedback",
        "updates", "changelog", "roadmap", "team", "partners",
        "resources", "guides", "tutorials", "demos", "examples",
        "overview", "details", "summary", "review", "preview",
        "insights", "analytics", "reports", "archives", "media",
        "onboarding", "billing", "subscriptions", "integrations", "webhooks"
    ]

    static func generate(asHTML: Bool = false) -> String {
        let path = paths.randomElement()!
        let url = "https://example.com/\(path)"
        guard asHTML else { return url }
        return "<a href=\"\(url)\">\(path.capitalized)</a>"
    }
}

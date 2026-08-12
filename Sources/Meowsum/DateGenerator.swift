import Foundation

enum DateLocale: String, CaseIterable, Identifiable {
    case unitedStates  = "United States"
    case unitedKingdom = "United Kingdom"
    case european      = "European"
    case iso           = "ISO 8601"
    case longForm      = "Long Form"
    case relative      = "Relative"

    var id: String { rawValue }
}

struct DateGenerator {
    static func generate(locale: DateLocale = .unitedStates) -> String {
        let now = Date()
        guard let ceiling = Calendar.current.date(byAdding: .year, value: 2, to: now) else {
            return ""
        }
        let maxSeconds = ceiling.timeIntervalSince(now)
        let offset = Double.random(in: 86_400...maxSeconds) // at least 1 day ahead
        let date = Date(timeIntervalSinceNow: offset)

        if locale == .relative {
            let fmt = RelativeDateTimeFormatter()
            fmt.unitsStyle = .full
            return fmt.localizedString(for: date, relativeTo: now)
        }

        let fmt = DateFormatter()
        fmt.locale = Locale(identifier: "en_US_POSIX")

        switch locale {
        case .unitedStates:  fmt.dateFormat = "M/d/yyyy"
        case .unitedKingdom: fmt.dateFormat = "dd/MM/yyyy"
        case .european:      fmt.dateFormat = "dd.MM.yyyy"
        case .iso:           fmt.dateFormat = "yyyy-MM-dd"
        case .longForm:      fmt.dateFormat = "MMMM d, yyyy"
        case .relative:      break
        }

        return fmt.string(from: date)
    }
}

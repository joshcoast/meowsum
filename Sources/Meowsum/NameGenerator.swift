import Foundation

struct NameGenerator {
    static let firstNames: [String] = [
        "James", "Oliver", "William", "Benjamin", "Lucas", "Henry",
        "Alexander", "Mason", "Ethan", "Daniel", "Jacob", "Logan",
        "Jackson", "Sebastian", "Jack", "Aiden", "Owen", "Samuel",
        "Ryan", "Nathan", "Caleb", "Isaac", "Elijah", "Dylan",
        "Liam", "Noah", "Gabriel", "Anthony", "Julian", "Wyatt",
        "Joshua", "Christopher", "Andrew", "Matthew", "David", "Marcus",
        "Emma", "Olivia", "Ava", "Isabella", "Sophia", "Charlotte",
        "Mia", "Amelia", "Harper", "Evelyn", "Abigail", "Emily",
        "Elizabeth", "Mila", "Ella", "Avery", "Sofia", "Camila",
        "Aria", "Scarlett", "Victoria", "Madison", "Luna", "Grace",
        "Chloe", "Penelope", "Layla", "Riley", "Zoey", "Nora",
        "Alexandra", "Jennifer", "Jessica", "Amanda", "Michelle", "Nicole",
        "Brianna", "Natalie", "Hannah", "Samantha", "Katherine", "Rebecca"
    ]

    static let middleNames: [String] = [
        "Richard", "Thomas", "Edward", "Michael", "James", "Robert",
        "David", "George", "Charles", "Joseph", "Alexander", "William",
        "Henry", "John", "Francis", "Patrick", "Vincent", "Lawrence",
        "Frederick", "Theodore", "Anthony", "Christopher", "Daniel",
        "Anne", "Marie", "Louise", "Grace", "Rose", "Elizabeth",
        "Jane", "Claire", "Kate", "Lynn", "Mae", "Lee", "Ray",
        "Dean", "Blair", "Quinn", "Sage", "Brooke", "Dawn",
        "Faith", "Hope", "Joy", "Paige", "Skye", "Lane", "Wren"
    ]

    static let lastNames: [String] = [
        "Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia",
        "Miller", "Davis", "Rodriguez", "Martinez", "Hernandez", "Lopez",
        "Gonzalez", "Wilson", "Anderson", "Thomas", "Taylor", "Moore",
        "Jackson", "Martin", "Lee", "Perez", "Thompson", "White",
        "Harris", "Sanchez", "Clark", "Ramirez", "Lewis", "Robinson",
        "Walker", "Young", "Allen", "King", "Wright", "Scott",
        "Torres", "Nguyen", "Hill", "Flores", "Green", "Adams",
        "Nelson", "Baker", "Hall", "Rivera", "Campbell", "Mitchell",
        "Carter", "Roberts", "Coast", "Finch", "Hayes", "Porter",
        "Ward", "Coleman", "Barnes", "Griffin", "Foster", "Reed",
        "Cooper", "Bailey", "Bell", "Murphy", "Cox",
        "Rogers", "Howard", "Jenkins", "Perry", "Powell", "Long"
    ]

    static func generate() -> String {
        "\(firstNames.randomElement()!) \(middleNames.randomElement()!) \(lastNames.randomElement()!)"
    }
}

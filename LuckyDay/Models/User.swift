import Foundation

struct User: Codable {
    var birthDate: Date
    var name: String?

    init(birthDate: Date, name: String? = nil) {
        self.birthDate = birthDate
        self.name = name
    }
}

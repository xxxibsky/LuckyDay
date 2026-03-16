import Foundation
import SwiftUI

struct DailyPrediction: Codable, Identifiable {
    let id: UUID
    let date: Date
    let luckyColor: String
    let colorHex: String
    let outfitSuggestion: String
    let activities: [String]
    let recommendations: String
    let aiProvider: AIProvider

    init(
        id: UUID = UUID(),
        date: Date,
        luckyColor: String,
        colorHex: String,
        outfitSuggestion: String,
        activities: [String],
        recommendations: String,
        aiProvider: AIProvider
    ) {
        self.id = id
        self.date = date
        self.luckyColor = luckyColor
        self.colorHex = colorHex
        self.outfitSuggestion = outfitSuggestion
        self.activities = activities
        self.recommendations = recommendations
        self.aiProvider = aiProvider
    }

    var color: Color {
        Color(hex: colorHex) ?? .blue
    }
}

// Helper extension to create Color from hex string
extension Color {
    init?(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return nil
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

import Foundation

enum AIProvider: String, Codable, CaseIterable {
    case openai = "OpenAI"
    case claude = "Claude"
    case gemini = "Gemini"

    var displayName: String {
        return self.rawValue
    }

    var icon: String {
        switch self {
        case .openai:
            return "brain.head.profile"
        case .claude:
            return "sparkles"
        case .gemini:
            return "star.fill"
        }
    }

    var apiEndpoint: String {
        switch self {
        case .openai:
            return "https://api.openai.com/v1/chat/completions"
        case .claude:
            return "https://api.anthropic.com/v1/messages"
        case .gemini:
            return "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent"
        }
    }
}

import Foundation

class AIService {
    static let shared = AIService()

    private init() {}

    func generateDailyPrediction(
        birthDate: Date,
        currentDate: Date = Date(),
        provider: AIProvider,
        apiKey: String
    ) async throws -> DailyPrediction {
        let prompt = createPrompt(birthDate: birthDate, currentDate: currentDate)

        let response: String
        switch provider {
        case .openai:
            response = try await callOpenAI(prompt: prompt, apiKey: apiKey)
        case .claude:
            response = try await callClaude(prompt: prompt, apiKey: apiKey)
        case .gemini:
            response = try await callGemini(prompt: prompt, apiKey: apiKey)
        }

        return try parsePrediction(response: response, date: currentDate, provider: provider)
    }

    private func createPrompt(birthDate: Date, currentDate: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        let birthDateString = formatter.string(from: birthDate)
        let currentDateString = formatter.string(from: currentDate)

        return """
        Based on the birth date \(birthDateString) and today's date \(currentDateString), provide a daily fortune prediction in JSON format with the following structure:
        {
            "luckyColor": "name of the color",
            "colorHex": "hex code of the color (e.g., #FF5733)",
            "outfitSuggestion": "detailed outfit suggestion incorporating the lucky color",
            "activities": ["activity 1", "activity 2", "activity 3"],
            "recommendations": "general recommendations and advice for the day"
        }

        Make the prediction creative, positive, and personalized. The activities should be specific and actionable. The recommendations should be encouraging and thoughtful.
        """
    }

    // MARK: - OpenAI
    private func callOpenAI(prompt: String, apiKey: String) async throws -> String {
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [
                ["role": "system", "content": "You are a fortune teller providing daily predictions. Always respond with valid JSON only."],
                ["role": "user", "content": prompt]
            ],
            "temperature": 0.8
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw AIServiceError.invalidResponse
        }

        guard httpResponse.statusCode == 200 else {
            throw AIServiceError.apiError(statusCode: httpResponse.statusCode)
        }

        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
              let choices = json["choices"] as? [[String: Any]],
              let firstChoice = choices.first,
              let message = firstChoice["message"] as? [String: Any],
              let content = message["content"] as? String else {
            throw AIServiceError.invalidResponse
        }

        return content
    }

    // MARK: - Claude
    private func callClaude(prompt: String, apiKey: String) async throws -> String {
        let url = URL(string: "https://api.anthropic.com/v1/messages")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("2023-06-01", forHTTPHeaderField: "anthropic-version")

        let body: [String: Any] = [
            "model": "claude-3-5-sonnet-20241022",
            "max_tokens": 1024,
            "messages": [
                ["role": "user", "content": prompt]
            ]
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw AIServiceError.invalidResponse
        }

        guard httpResponse.statusCode == 200 else {
            throw AIServiceError.apiError(statusCode: httpResponse.statusCode)
        }

        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
              let content = json["content"] as? [[String: Any]],
              let firstContent = content.first,
              let text = firstContent["text"] as? String else {
            throw AIServiceError.invalidResponse
        }

        return text
    }

    // MARK: - Gemini
    private func callGemini(prompt: String, apiKey: String) async throws -> String {
        let url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=\(apiKey)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "contents": [
                ["parts": [["text": prompt]]]
            ]
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw AIServiceError.invalidResponse
        }

        guard httpResponse.statusCode == 200 else {
            throw AIServiceError.apiError(statusCode: httpResponse.statusCode)
        }

        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
              let candidates = json["candidates"] as? [[String: Any]],
              let firstCandidate = candidates.first,
              let content = firstCandidate["content"] as? [String: Any],
              let parts = content["parts"] as? [[String: Any]],
              let firstPart = parts.first,
              let text = firstPart["text"] as? String else {
            throw AIServiceError.invalidResponse
        }

        return text
    }

    // MARK: - Response Parsing
    private func parsePrediction(response: String, date: Date, provider: AIProvider) throws -> DailyPrediction {
        // Extract JSON from response (in case there's markdown formatting)
        let jsonString = extractJSON(from: response)

        guard let jsonData = jsonString.data(using: .utf8),
              let json = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] else {
            throw AIServiceError.parsingError
        }

        guard let luckyColor = json["luckyColor"] as? String,
              let colorHex = json["colorHex"] as? String,
              let outfitSuggestion = json["outfitSuggestion"] as? String,
              let activities = json["activities"] as? [String],
              let recommendations = json["recommendations"] as? String else {
            throw AIServiceError.parsingError
        }

        return DailyPrediction(
            date: date,
            luckyColor: luckyColor,
            colorHex: colorHex,
            outfitSuggestion: outfitSuggestion,
            activities: activities,
            recommendations: recommendations,
            aiProvider: provider
        )
    }

    private func extractJSON(from response: String) -> String {
        // Remove markdown code blocks if present
        if let range = response.range(of: "```json\\s*(.+?)\\s*```", options: .regularExpression) {
            let jsonMatch = String(response[range])
            return jsonMatch
                .replacingOccurrences(of: "```json", with: "")
                .replacingOccurrences(of: "```", with: "")
                .trimmingCharacters(in: .whitespacesAndNewlines)
        }

        // Try to find JSON object in the response
        if let startIndex = response.firstIndex(of: "{"),
           let endIndex = response.lastIndex(of: "}") {
            return String(response[startIndex...endIndex])
        }

        return response
    }
}

enum AIServiceError: Error, LocalizedError {
    case invalidResponse
    case apiError(statusCode: Int)
    case parsingError
    case invalidAPIKey

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response from AI service"
        case .apiError(let statusCode):
            return "API error with status code: \(statusCode)"
        case .parsingError:
            return "Failed to parse prediction response"
        case .invalidAPIKey:
            return "Invalid API key. Please check your settings."
        }
    }
}

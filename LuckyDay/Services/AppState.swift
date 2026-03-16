import Foundation
import SwiftUI

class AppState: ObservableObject {
    @Published var user: User?
    @Published var predictions: [DailyPrediction] = []
    @Published var selectedProvider: AIProvider = .openai
    @Published var apiKeys: [AIProvider: String] = [:]
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let userDefaults = UserDefaults.standard
    private let userKey = "savedUser"
    private let predictionsKey = "savedPredictions"
    private let selectedProviderKey = "selectedProvider"
    private let apiKeysKey = "apiKeys"

    init() {
        loadUser()
        loadPredictions()
        loadSelectedProvider()
        loadAPIKeys()
    }

    // MARK: - User Management
    func saveUser(_ user: User) {
        self.user = user
        if let encoded = try? JSONEncoder().encode(user) {
            userDefaults.set(encoded, forKey: userKey)
        }
    }

    private func loadUser() {
        if let data = userDefaults.data(forKey: userKey),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            self.user = user
        }
    }

    var hasCompletedOnboarding: Bool {
        return user != nil
    }

    // MARK: - Predictions Management
    func savePrediction(_ prediction: DailyPrediction) {
        // Remove prediction for the same date if it exists
        predictions.removeAll { Calendar.current.isDate($0.date, inSameDayAs: prediction.date) }

        predictions.insert(prediction, at: 0)
        savePredictions()
    }

    private func savePredictions() {
        if let encoded = try? JSONEncoder().encode(predictions) {
            userDefaults.set(encoded, forKey: predictionsKey)
        }
    }

    private func loadPredictions() {
        if let data = userDefaults.data(forKey: predictionsKey),
           let predictions = try? JSONDecoder().decode([DailyPrediction].self, from: data) {
            self.predictions = predictions
        }
    }

    func getTodaysPrediction() -> DailyPrediction? {
        predictions.first { Calendar.current.isDateInToday($0.date) }
    }

    // MARK: - AI Provider Management
    func setSelectedProvider(_ provider: AIProvider) {
        selectedProvider = provider
        userDefaults.set(provider.rawValue, forKey: selectedProviderKey)
    }

    private func loadSelectedProvider() {
        if let providerString = userDefaults.string(forKey: selectedProviderKey),
           let provider = AIProvider(rawValue: providerString) {
            selectedProvider = provider
        }
    }

    func setAPIKey(_ key: String, for provider: AIProvider) {
        apiKeys[provider] = key
        saveAPIKeys()
    }

    private func saveAPIKeys() {
        let keysDict = apiKeys.mapValues { $0 }
        if let encoded = try? JSONEncoder().encode(keysDict) {
            userDefaults.set(encoded, forKey: apiKeysKey)
        }
    }

    private func loadAPIKeys() {
        if let data = userDefaults.data(forKey: apiKeysKey),
           let decoded = try? JSONDecoder().decode([AIProvider: String].self, from: data) {
            apiKeys = decoded
        }
    }

    // MARK: - Generate Prediction
    func generateTodaysPrediction() async {
        guard let user = user else { return }

        guard let apiKey = apiKeys[selectedProvider], !apiKey.isEmpty else {
            await MainActor.run {
                errorMessage = "Please set your \(selectedProvider.displayName) API key in settings"
            }
            return
        }

        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }

        do {
            let prediction = try await AIService.shared.generateDailyPrediction(
                birthDate: user.birthDate,
                provider: selectedProvider,
                apiKey: apiKey
            )

            await MainActor.run {
                savePrediction(prediction)
                isLoading = false
            }
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
                isLoading = false
            }
        }
    }
}

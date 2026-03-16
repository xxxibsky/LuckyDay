import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appState: AppState
    @State private var showingAPIKeyAlert = false
    @State private var tempAPIKey = ""
    @State private var selectedProviderForKey: AIProvider = .openai

    var body: some View {
        NavigationView {
            Form {
                // AI Provider Selection
                Section(header: Text("AI Provider")) {
                    ForEach(AIProvider.allCases, id: \.self) { provider in
                        HStack {
                            Image(systemName: provider.icon)
                                .foregroundColor(appState.selectedProvider == provider ? .blue : .gray)

                            VStack(alignment: .leading) {
                                Text(provider.displayName)
                                    .font(.body)

                                if let apiKey = appState.apiKeys[provider], !apiKey.isEmpty {
                                    Text("API Key configured")
                                        .font(.caption)
                                        .foregroundColor(.green)
                                } else {
                                    Text("API Key required")
                                        .font(.caption)
                                        .foregroundColor(.orange)
                                }
                            }

                            Spacer()

                            if appState.selectedProvider == provider {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            appState.setSelectedProvider(provider)
                        }
                    }
                }

                // API Keys Configuration
                Section(header: Text("API Keys"), footer: Text("Your API keys are stored securely on your device and never shared.")) {
                    ForEach(AIProvider.allCases, id: \.self) { provider in
                        Button(action: {
                            selectedProviderForKey = provider
                            tempAPIKey = appState.apiKeys[provider] ?? ""
                            showingAPIKeyAlert = true
                        }) {
                            HStack {
                                Image(systemName: provider.icon)
                                    .foregroundColor(.blue)

                                Text("\(provider.displayName) API Key")
                                    .foregroundColor(.primary)

                                Spacer()

                                if let apiKey = appState.apiKeys[provider], !apiKey.isEmpty {
                                    Text(maskedAPIKey(apiKey))
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }

                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }

                // User Information
                if let user = appState.user {
                    Section(header: Text("Profile")) {
                        if let name = user.name {
                            HStack {
                                Text("Name")
                                Spacer()
                                Text(name)
                                    .foregroundColor(.secondary)
                            }
                        }

                        HStack {
                            Text("Birth Date")
                            Spacer()
                            Text(formattedDate(user.birthDate))
                                .foregroundColor(.secondary)
                        }
                    }
                }

                // How to get API Keys
                Section(header: Text("How to Get API Keys")) {
                    Link(destination: URL(string: "https://platform.openai.com/api-keys")!) {
                        HStack {
                            Image(systemName: "link")
                            Text("Get OpenAI API Key")
                            Spacer()
                            Image(systemName: "arrow.up.right.square")
                                .font(.caption)
                        }
                    }

                    Link(destination: URL(string: "https://console.anthropic.com/settings/keys")!) {
                        HStack {
                            Image(systemName: "link")
                            Text("Get Claude API Key")
                            Spacer()
                            Image(systemName: "arrow.up.right.square")
                                .font(.caption)
                        }
                    }

                    Link(destination: URL(string: "https://aistudio.google.com/app/apikey")!) {
                        HStack {
                            Image(systemName: "link")
                            Text("Get Gemini API Key")
                            Spacer()
                            Image(systemName: "arrow.up.right.square")
                                .font(.caption)
                        }
                    }
                }

                // App Information
                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
            .alert("Enter API Key", isPresented: $showingAPIKeyAlert) {
                TextField("API Key", text: $tempAPIKey)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()

                Button("Cancel", role: .cancel) {
                    tempAPIKey = ""
                }

                Button("Save") {
                    appState.setAPIKey(tempAPIKey, for: selectedProviderForKey)
                    tempAPIKey = ""
                }
            } message: {
                Text("Enter your \(selectedProviderForKey.displayName) API key")
            }
        }
    }

    private func maskedAPIKey(_ key: String) -> String {
        guard key.count > 8 else { return "••••••" }
        let prefix = String(key.prefix(4))
        let suffix = String(key.suffix(4))
        return "\(prefix)••••\(suffix)"
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}

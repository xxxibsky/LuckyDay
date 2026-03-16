import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var appState: AppState
    @State private var birthDate = Date()
    @State private var name = ""
    @State private var showingDatePicker = false

    var body: some View {
        NavigationView {
            ZStack {
                // Gradient background
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple.opacity(0.6), Color.blue.opacity(0.4)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 30) {
                    Spacer()

                    // App icon/logo
                    Image(systemName: "sparkles")
                        .font(.system(size: 80))
                        .foregroundColor(.white)

                    Text("LuckyDay")
                        .font(.system(size: 42, weight: .bold))
                        .foregroundColor(.white)

                    Text("Discover your daily fortune")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.9))

                    Spacer()

                    VStack(spacing: 20) {
                        // Name field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Name (Optional)")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))

                            TextField("Enter your name", text: $name)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(12)
                                .foregroundColor(.white)
                        }

                        // Birth date picker
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Birth Date")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))

                            DatePicker(
                                "Birth Date",
                                selection: $birthDate,
                                displayedComponents: .date
                            )
                            .datePickerStyle(.compact)
                            .labelsHidden()
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(12)
                            .colorScheme(.dark)
                        }

                        // Continue button
                        Button(action: {
                            let user = User(
                                birthDate: birthDate,
                                name: name.isEmpty ? nil : name
                            )
                            appState.saveUser(user)
                        }) {
                            Text("Get Started")
                                .font(.headline)
                                .foregroundColor(.purple)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                        }
                        .padding(.top, 10)
                    }
                    .padding(.horizontal, 30)

                    Spacer()
                }
            }
        }
    }
}

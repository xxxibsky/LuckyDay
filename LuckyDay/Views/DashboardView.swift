import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var appState: AppState
    @State private var showingError = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    if let prediction = appState.getTodaysPrediction() {
                        // Today's prediction exists
                        PredictionCard(prediction: prediction)
                    } else {
                        // No prediction for today
                        EmptyPredictionView()
                    }

                    if appState.isLoading {
                        ProgressView("Consulting the stars...")
                            .padding()
                    }

                    if let errorMessage = appState.errorMessage {
                        ErrorView(message: errorMessage)
                    }
                }
                .padding()
            }
            .navigationTitle("Today's Fortune")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        Task {
                            await appState.generateTodaysPrediction()
                        }
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                    .disabled(appState.isLoading)
                }
            }
        }
    }
}

struct PredictionCard: View {
    let prediction: DailyPrediction

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Lucky Color Display with animation
            VStack(spacing: 15) {
                Text("Your Lucky Color")
                    .font(.headline)
                    .foregroundColor(.secondary)

                ZStack {
                    Circle()
                        .fill(prediction.color)
                        .frame(width: 120, height: 120)
                        .shadow(color: prediction.color.opacity(0.5), radius: 20, x: 0, y: 10)

                    Circle()
                        .fill(prediction.color.opacity(0.3))
                        .frame(width: 150, height: 150)
                        .blur(radius: 10)
                }

                Text(prediction.luckyColor)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(prediction.color)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)

            Divider()

            // Outfit Suggestion
            SectionView(
                icon: "tshirt.fill",
                iconColor: prediction.color,
                title: "What to Wear",
                content: prediction.outfitSuggestion
            )

            Divider()

            // Activities
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "list.bullet")
                        .foregroundColor(prediction.color)
                    Text("Recommended Activities")
                        .font(.headline)
                }

                ForEach(prediction.activities, id: \.self) { activity in
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(prediction.color)
                            .font(.system(size: 12))
                            .padding(.top, 4)

                        Text(activity)
                            .font(.body)
                    }
                }
            }

            Divider()

            // General Recommendations
            SectionView(
                icon: "lightbulb.fill",
                iconColor: prediction.color,
                title: "Today's Advice",
                content: prediction.recommendations
            )

            // Powered by
            HStack {
                Spacer()
                Text("Powered by \(prediction.aiProvider.displayName)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Image(systemName: prediction.aiProvider.icon)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding(.top, 10)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

struct SectionView: View {
    let icon: String
    let iconColor: Color
    let title: String
    let content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(iconColor)
                Text(title)
                    .font(.headline)
            }

            Text(content)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct EmptyPredictionView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "sparkles")
                .font(.system(size: 60))
                .foregroundColor(.purple)

            Text("No Prediction Yet")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Tap the button below to discover your fortune for today")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button(action: {
                Task {
                    await appState.generateTodaysPrediction()
                }
            }) {
                HStack {
                    Image(systemName: "wand.and.stars")
                    Text("Generate Prediction")
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.purple, Color.blue]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(12)
            }
            .disabled(appState.isLoading)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

struct ErrorView: View {
    let message: String

    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.orange)

            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.orange.opacity(0.1))
        .cornerRadius(8)
    }
}

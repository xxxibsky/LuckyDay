import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationView {
            Group {
                if appState.predictions.isEmpty {
                    EmptyHistoryView()
                } else {
                    List {
                        ForEach(appState.predictions) { prediction in
                            NavigationLink(destination: PredictionDetailView(prediction: prediction)) {
                                HistoryRow(prediction: prediction)
                            }
                        }
                    }
                }
            }
            .navigationTitle("History")
        }
    }
}

struct HistoryRow: View {
    let prediction: DailyPrediction

    var body: some View {
        HStack(spacing: 15) {
            // Color circle
            Circle()
                .fill(prediction.color)
                .frame(width: 50, height: 50)
                .shadow(color: prediction.color.opacity(0.3), radius: 5, x: 0, y: 2)

            VStack(alignment: .leading, spacing: 4) {
                Text(prediction.luckyColor)
                    .font(.headline)
                    .foregroundColor(prediction.color)

                Text(formattedDate(prediction.date))
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                HStack(spacing: 4) {
                    Image(systemName: prediction.aiProvider.icon)
                        .font(.caption2)
                    Text(prediction.aiProvider.displayName)
                        .font(.caption)
                }
                .foregroundColor(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct PredictionDetailView: View {
    let prediction: DailyPrediction

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                PredictionCard(prediction: prediction)
            }
            .padding()
        }
        .navigationTitle(formattedDate(prediction.date))
        .navigationBarTitleDisplayMode(.inline)
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}

struct EmptyHistoryView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "calendar.badge.clock")
                .font(.system(size: 60))
                .foregroundColor(.gray)

            Text("No History Yet")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Your daily predictions will appear here")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

import SwiftUI
import UserNotifications

@main
struct LuckyDayApp: App {
    @StateObject private var appState = AppState()

    init() {
        // Request notification permissions on app launch
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            if granted {
                print("Notification permission granted")
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}

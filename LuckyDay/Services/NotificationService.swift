import Foundation
import UserNotifications

class NotificationService {
    static let shared = NotificationService()

    private init() {}

    func scheduleDailyNotification(at hour: Int = 9, minute: Int = 0) {
        let content = UNMutableNotificationContent()
        content.title = "Your Daily Fortune Awaits"
        content.body = "Discover your lucky color and today's recommendations"
        content.sound = .default

        // Create a date components object for the notification time
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute

        // Create a calendar-based trigger
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        // Create the request
        let request = UNNotificationRequest(
            identifier: "dailyFortune",
            content: content,
            trigger: trigger
        )

        // Schedule the notification
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Daily notification scheduled for \(hour):\(String(format: "%02d", minute))")
            }
        }
    }

    func cancelDailyNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(
            withIdentifiers: ["dailyFortune"]
        )
    }

    func checkNotificationPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus == .authorized)
            }
        }
    }
}

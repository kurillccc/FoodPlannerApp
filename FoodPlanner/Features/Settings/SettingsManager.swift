//
//  SettingsManager.swift
//  FoodPlanner
//
//  Created by Кирилл on 25.05.2026.
//

import UIKit
import UserNotifications

final class SettingsManager {

    // MARK: - Types

    enum Theme: Int {
        case system = 0
        case light = 1
        case dark = 2

        var interfaceStyle: UIUserInterfaceStyle {
            switch self {
            case .system:
                return .unspecified
            case .light:
                return .light
            case .dark:
                return .dark
            }
        }
    }

    // MARK: - Properties

    static let shared = SettingsManager()

    static let didChangeNotification = Notification.Name("settingsDidChange")

    private let themeKey = "settings.theme"
    private let notificationsKey = "settings.notificationsEnabled"

    private init() {}

    var theme: Theme {
        get {
            Theme(rawValue: UserDefaults.standard.integer(forKey: themeKey)) ?? .system
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: themeKey)
            notifyChanged()
        }
    }

    var notificationsEnabled: Bool {
        get {
            UserDefaults.standard.bool(forKey: notificationsKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: notificationsKey)
            notifyChanged()
        }
    }

    // MARK: - Notifications

    @MainActor
    func requestNotificationPermissionIfNeeded() async -> Bool {
        let center = UNUserNotificationCenter.current()

        let settings = await center.notificationSettings()
        switch settings.authorizationStatus {
        case .authorized, .provisional, .ephemeral:
            return true
        case .denied:
            return false
        case .notDetermined:
            do {
                return try await center.requestAuthorization(options: [.alert, .badge, .sound])
            } catch {
                return false
            }
        @unknown default:
            return false
        }
    }

    @MainActor
    func syncNotificationsEnabledFromSystem() async {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        let enabled: Bool
        switch settings.authorizationStatus {
        case .authorized, .provisional, .ephemeral:
            enabled = true
        case .denied, .notDetermined:
            enabled = false
        @unknown default:
            enabled = false
        }
        UserDefaults.standard.set(enabled, forKey: notificationsKey)
        notifyChanged()
    }

    // MARK: - Public

    func applyThemeToAppWindows() {
        let style = theme.interfaceStyle

        let scenes = UIApplication.shared.connectedScenes
        for case let windowScene as UIWindowScene in scenes {
            for window in windowScene.windows {
                window.overrideUserInterfaceStyle = style
            }
        }
    }

    func resetToDefaults() {
        UserDefaults.standard.removeObject(forKey: themeKey)
        UserDefaults.standard.removeObject(forKey: notificationsKey)
        applyThemeToAppWindows()
        NotificationCenter.default.post(name: Self.didChangeNotification, object: nil)
    }

    // MARK: - Private

    private func notifyChanged() {
        NotificationCenter.default.post(name: Self.didChangeNotification, object: nil)
        applyThemeToAppWindows()
    }
}

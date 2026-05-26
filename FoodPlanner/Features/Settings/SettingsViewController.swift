//
//  SettingsViewController.swift
//  FoodPlanner
//
//  Created by Кирилл on 25.05.2026.
//

import UIKit

final class SettingsViewController: UITableViewController {

    // MARK: - Types

    private enum Section: Int, CaseIterable {
        case appearance
        case notifications
        case account
        case reset

        var title: String {
            switch self {
            case .appearance:
                return "Appearance"
            case .notifications:
                return "Notifications"
            case .account:
                return "Account"
            case .reset:
                return ""
            }
        }

        var footerText: String? {
            switch self {
            case .appearance:
                return "Changes the app appearance immediately and saves the choice."
            case .notifications:
                return "Enable notifications to receive important updates."
            case .account:
                return "Login will be implemented later."
            case .reset:
                return nil
            }
        }
    }

    // MARK: - Properties

    private let settings = SettingsManager.shared

    // MARK: - Init

    init() {
        super.init(style: .plain)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Settings"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true

        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 16, right: 0)

        tableView.register(SegmentedCapsuleCell.self, forCellReuseIdentifier: SegmentedCapsuleCell.reuseIdentifier)
        tableView.register(ToggleCapsuleCell.self, forCellReuseIdentifier: ToggleCapsuleCell.reuseIdentifier)
        tableView.register(ValueCapsuleCell.self, forCellReuseIdentifier: ValueCapsuleCell.reuseIdentifier)

        Task { [weak self] in
            guard let self else { return }
            await settings.syncNotificationsEnabledFromSystem()
            tableView.reloadData()
        }
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .appearance:
            return 1
        case .notifications:
            return 1
        case .account:
            return 1
        case .reset:
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Section(rawValue: section) else { return nil }
        return section.title.isEmpty ? nil : section.title
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            return UITableViewCell()
        }

        switch section {
        case .appearance:
            let cell = tableView.dequeueReusableCell(withIdentifier: SegmentedCapsuleCell.reuseIdentifier, for: indexPath)
            if let cell = cell as? SegmentedCapsuleCell {
                cell.configure(selectedIndex: settings.theme.rawValue) { [weak self] index in
                    self?.settings.theme = SettingsManager.Theme(rawValue: index) ?? .system
                }
            }
            return cell

        case .notifications:
            let cell = tableView.dequeueReusableCell(withIdentifier: ToggleCapsuleCell.reuseIdentifier, for: indexPath)
            if let cell = cell as? ToggleCapsuleCell {
                cell.configure(title: "Enable notifications", isOn: settings.notificationsEnabled) { [weak self] isOn in
                    guard let self else { return }

                    if isOn {
                        Task { [weak self] in
                            guard let self else { return }
                            let granted = await settings.requestNotificationPermissionIfNeeded()
                            if granted {
                                settings.notificationsEnabled = true
                            } else {
                                settings.notificationsEnabled = false
                                tableView.reloadRows(at: [indexPath], with: .none)

                                let alert = UIAlertController(
                                    title: "Notifications disabled",
                                    message: "Enable notifications in iOS Settings to receive alerts.",
                                    preferredStyle: .alert
                                )
                                alert.addAction(UIAlertAction(title: "OK", style: .default))
                                present(alert, animated: true)
                            }
                        }
                    } else {
                        settings.notificationsEnabled = false
                    }
                }
            }
            return cell

        case .account:
            let cell = tableView.dequeueReusableCell(withIdentifier: ValueCapsuleCell.reuseIdentifier, for: indexPath)
            if let cell = cell as? ValueCapsuleCell {
                cell.configure(title: "Registration", value: "Not available") { [weak self] in
                    self?.presentLoginPlaceholder()
                }
            }
            return cell

        case .reset:
            let cell = tableView.dequeueReusableCell(withIdentifier: ValueCapsuleCell.reuseIdentifier, for: indexPath)
            if let cell = cell as? ValueCapsuleCell {
                cell.configure(title: "Reset to Defaults", value: nil) { [weak self] in
                    self?.confirmReset()
                }
                cell.setTitleColor(.systemRed)
            }
            return cell
        }
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let section = Section(rawValue: section), let text = section.footerText else { return nil }

        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0

        let container = UIView()
        container.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 32),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -32),
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 4),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12)
        ])

        return container
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let section = Section(rawValue: section), section.footerText != nil else { return .leastNormalMagnitude }
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        44
    }

    // MARK: - Private

    private func presentLoginPlaceholder() {
        let alert = UIAlertController(title: "Account", message: "Coming soon", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func confirmReset() {
        let alert = UIAlertController(
            title: "Reset to defaults",
            message: "Reset all settings to defaults?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Reset", style: .destructive) { [weak self] _ in
            self?.settings.resetToDefaults()
            self?.tableView.reloadData()
        })
        present(alert, animated: true)
    }
}

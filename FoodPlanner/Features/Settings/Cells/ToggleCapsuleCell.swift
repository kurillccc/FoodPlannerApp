//
//  ToggleCapsuleCell.swift
//  FoodPlanner
//
//  Created by Кирилл on 25.05.2026.
//

import UIKit

final class ToggleCapsuleCell: CapsuleTableViewCell {

    // MARK: - Style Overrides

    override var capsuleCornerRadius: CGFloat { 30 }
    override var capsuleBackgroundInsets: NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    }
    override var capsuleContentMargins: NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: 22, leading: 22, bottom: 22, trailing: 22)
    }

    // MARK: - Properties

    static let reuseIdentifier = "ToggleCapsuleCell"

    private let titleLabel = UILabel()
    private let toggleSwitch = UISwitch()

    private var onChange: ((Bool) -> Void)?

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        embedViews()
        setupBehavior()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Public

    func configure(title: String, isOn: Bool, onChange: @escaping (Bool) -> Void) {
        titleLabel.text = title
        toggleSwitch.isOn = isOn
        self.onChange = onChange
    }

    // MARK: - Private

    private func embedViews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        toggleSwitch.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.font = .systemFont(ofSize: 17, weight: .regular)

        contentView.addSubview(titleLabel)
        contentView.addSubview(toggleSwitch)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            toggleSwitch.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            toggleSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: toggleSwitch.leadingAnchor, constant: -12)
        ])
    }

    private func setupBehavior() {
        toggleSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
    }

    @objc private func switchChanged() {
        onChange?(toggleSwitch.isOn)
    }
}

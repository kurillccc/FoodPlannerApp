//
//  ValueCapsuleCell.swift
//  FoodPlanner
//
//  Created by Кирилл on 25.05.2026.
//

import UIKit

final class ValueCapsuleCell: CapsuleTableViewCell {

    // MARK: - Style Overrides

    override var capsuleCornerRadius: CGFloat { 30 }
    override var capsuleBackgroundInsets: NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    }
    override var capsuleContentMargins: NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: 22, leading: 22, bottom: 22, trailing: 22)
    }

    // MARK: - Properties

    static let reuseIdentifier = "ValueCapsuleCell"

    private let titleLabel = UILabel()
    private let valueLabel = UILabel()

    private var onTap: (() -> Void)?

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        embedViews()
        setupBehavior()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Public

    func configure(title: String, value: String?, valueColor: UIColor = .secondaryLabel, onTap: (() -> Void)? = nil) {
        titleLabel.text = title
        valueLabel.text = value
        valueLabel.textColor = valueColor
        self.onTap = onTap

        accessoryType = onTap == nil ? .none : .disclosureIndicator
        selectionStyle = onTap == nil ? .none : .default
    }

    func setTitleColor(_ color: UIColor) {
        titleLabel.textColor = color
    }

    // MARK: - Private

    private func embedViews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        valueLabel.font = .systemFont(ofSize: 17, weight: .regular)
        valueLabel.setContentHuggingPriority(.required, for: .horizontal)

        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            valueLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: valueLabel.leadingAnchor, constant: -12)
        ])
    }

    private func setupBehavior() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        contentView.addGestureRecognizer(tap)
    }

    @objc private func handleTap() {
        onTap?()
    }
}

//
//  SegmentedCapsuleCell.swift
//  FoodPlanner
//
//  Created by Кирилл on 25.05.2026.
//

import UIKit

final class SegmentedCapsuleCell: CapsuleTableViewCell {

    // MARK: - Properties

    static let reuseIdentifier = "SegmentedCapsuleCell"

    private let segmentedControl = UISegmentedControl(items: ["System", "Light", "Dark"])

    private var onChange: ((Int) -> Void)?

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        embedViews()
        setupBehavior()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Public

    func configure(selectedIndex: Int, onChange: @escaping (Int) -> Void) {
        segmentedControl.selectedSegmentIndex = selectedIndex
        self.onChange = onChange
    }

    // MARK: - Private

    private func embedViews() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(segmentedControl)

        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            segmentedControl.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }

    private func setupBehavior() {
        segmentedControl.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
    }

    @objc private func valueChanged() {
        onChange?(segmentedControl.selectedSegmentIndex)
    }
}

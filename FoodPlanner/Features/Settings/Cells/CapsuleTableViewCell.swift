//
//  CapsuleTableViewCell.swift
//  FoodPlanner
//
//  Created by Кирилл on 25.05.2026.
//

import UIKit

class CapsuleTableViewCell: UITableViewCell {

    // MARK: - Style Overrides

    var capsuleCornerRadius: CGFloat { 28 }
    var capsuleBackgroundInsets: NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10)
    }
    var capsuleContentMargins: NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24)
    }
    var capsuleStrokeWidth: CGFloat { 0.5 }

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyCapsuleStyle()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Private

    func applyCapsuleStyle() {
        selectionStyle = .none
        backgroundColor = .clear

        var background = UIBackgroundConfiguration.clear()
        background.backgroundColor = .secondarySystemBackground
        background.cornerRadius = capsuleCornerRadius
        background.backgroundInsets = capsuleBackgroundInsets
        background.strokeColor = UIColor.separator
        background.strokeWidth = capsuleStrokeWidth
        backgroundConfiguration = background

        contentView.directionalLayoutMargins = capsuleContentMargins
    }
}

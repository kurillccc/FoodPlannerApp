//
//  CartItemCell.swift
//  FoodPlanner
//
//  Created by Кирилл on 03.02.2026.
//

import UIKit

final class CartItemCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "CartItemCell"

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStyle()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}

// MARK: - Public

extension CartItemCell {
    
    func configure(with item: CartItem) {
        var content = UIListContentConfiguration.subtitleCell()
        content.text = item.product.title
        if let price = item.product.price {
            let nf = NumberFormatter()
            nf.numberStyle = .currency
            nf.currencyCode = "USD"
            content.secondaryText = "Qty: \(item.quantity)  •  \(nf.string(from: price as NSNumber) ?? "")"
        } else {
            content.secondaryText = "Qty: \(item.quantity)"
        }
        content.image = item.product.image
        content.imageProperties.maximumSize = CGSize(width: 56, height: 56)
        content.imageProperties.reservedLayoutSize = CGSize(width: 56, height: 56)
        content.imageProperties.cornerRadius = 12
        content.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        contentConfiguration = content
    }
    
}

// MARK: - Setup style

private extension CartItemCell {
    
    func setupStyle() {
        selectionStyle = .none
        backgroundColor = .clear

        var background = UIBackgroundConfiguration.clear()
        background.backgroundColor = .secondarySystemBackground
        background.strokeColor = UIColor.separator
        background.strokeWidth = 1
        background.cornerRadius = 22
        // Make the capsule wider
        background.backgroundInsets = NSDirectionalEdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)
        backgroundConfiguration = background
    }
    
}

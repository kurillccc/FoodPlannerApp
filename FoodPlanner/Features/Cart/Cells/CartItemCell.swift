//
//  CartItemCell.swift
//  FoodPlanner
//
//  Created by Кирилл on 03.02.2026.
//

import UIKit

final class CartItemCell: UITableViewCell {

    static let identifier = "CartItemCell"

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
        content.imageProperties.maximumSize = CGSize(width: 40, height: 40)
        self.contentConfiguration = content
        backgroundColor = .systemBackground
    }
    
}

// MARK: - Setup style

private extension CartItemCell {
    
    func setupStyle() {
        selectionStyle = .none
    }
    
}

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

    private var imageTask: Task<Void, Never>?
    private var currentImageURL: URL?

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStyle()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageTask?.cancel()
        imageTask = nil
        currentImageURL = nil
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
        content.image = item.product.image ?? UIImage(systemName: "photo")
        content.imageProperties.maximumSize = CGSize(width: 56, height: 56)
        content.imageProperties.reservedLayoutSize = CGSize(width: 56, height: 56)
        content.imageProperties.cornerRadius = 12
        content.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        contentConfiguration = content

        imageTask?.cancel()
        imageTask = nil

        if item.product.image == nil, let url = item.product.imageURL {
            currentImageURL = url
            imageTask = Task { [weak self] in
                guard let self else { return }
                let image = await ImageLoader.shared.loadImage(from: url)
                guard !Task.isCancelled, self.currentImageURL == url else { return }
                guard let image else { return }

                await MainActor.run {
                    var updated = UIListContentConfiguration.subtitleCell()
                    updated.text = content.text
                    updated.secondaryText = content.secondaryText
                    updated.image = image
                    updated.imageProperties.maximumSize = content.imageProperties.maximumSize
                    updated.imageProperties.reservedLayoutSize = content.imageProperties.reservedLayoutSize
                    updated.imageProperties.cornerRadius = content.imageProperties.cornerRadius
                    updated.directionalLayoutMargins = content.directionalLayoutMargins
                    self.contentConfiguration = updated
                }
            }
        }
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

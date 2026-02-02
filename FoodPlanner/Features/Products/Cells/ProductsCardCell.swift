//
//  ProductsCardCell.swift
//  FoodPlanner
//
//  Created by Кирилл on 01.02.2026.
//

import UIKit

final class ProductsCardCell: UICollectionViewCell {
    
    static let identifier = "ProductCardCell"

    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.setContentHuggingPriority(.defaultLow, for: .vertical)
        image.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return image
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        embedViews()
        setupStyle()
        setupLayout()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func configure(with product: ProductsModel) {
        imageView.image = product.image
        titleLabel.text = product.title
        if let price = product.price {
            priceLabel.text = format(price: price)
        } else {
            priceLabel.text = nil
        }
    }

    private func format(price: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: price as NSNumber) ?? ""
    }
    
}

// MARK: - Embed views

private extension ProductsCardCell {
    
    func embedViews() {
        contentView.addSubViews(
            imageView,
            titleLabel,
            priceLabel
        )
    }
    
}

// MARK: - Setup style

private extension ProductsCardCell {
    
    func setupStyle() {
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.separator.cgColor
    }
    
}

// MARK: - Setup layout

private extension ProductsCardCell {
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
}

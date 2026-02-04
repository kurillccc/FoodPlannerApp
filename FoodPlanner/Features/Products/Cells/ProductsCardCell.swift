//
//  ProductsCardCell.swift
//  FoodPlanner
//
//  Created by Кирилл on 01.02.2026.
//

import UIKit

final class ProductsCardCell: UICollectionViewCell {
    
    static let identifier = "ProductCardCell"
    
    var addToCartAction: ((ProductsModel) -> Void)?
    private var currentProduct: ProductsModel?

    private let quantityBadge: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.systemBlue
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var currentQuantity: Int = 0

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
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(AppColor.Primary.main, for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .tertiarySystemFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        embedViews()
        setupStyle()
        setupBehavior()
        setupLayout()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func configure(with product: ProductsModel) {
        imageView.image = product.image
        titleLabel.text = product.title
        currentProduct = product
        
        currentQuantity = 0
        updateQuantityBadge()
        
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

    private func updateQuantityBadge() {
        if currentQuantity > 0 {
            quantityBadge.isHidden = false
            quantityBadge.text = "\(currentQuantity)"
        } else {
            quantityBadge.isHidden = true
            quantityBadge.text = nil
        }
    }
    
}

// MARK: - Embed views

private extension ProductsCardCell {
    
    func embedViews() {
        contentView.addSubViews(
            imageView,
            titleLabel,
            priceLabel,
            addButton,
            quantityBadge
        )
    }
    
}

// MARK: - Setup style

private extension ProductsCardCell {
    
    func setupStyle() {
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.separator.cgColor
        contentView.backgroundColor = .systemBackground
        contentView.clipsToBounds = true
    }
    
}

// MARK: - Setup behavior

private extension ProductsCardCell {
    
    func setupBehavior() {
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addButton.accessibilityLabel = "Add to cart"
        addButton.accessibilityHint = "Double tap to add one more."
    }
    
    @objc private func addButtonTapped() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()

        UIView.animate(withDuration: 0.08, animations: {
            self.addButton.alpha = 0.7
            self.addButton.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
        }, completion: { _ in
            UIView.animate(withDuration: 0.12) {
                self.addButton.alpha = 1.0
                self.addButton.transform = .identity
            }
        })

        guard let product = currentProduct else { return }
        currentQuantity += 1
        updateQuantityBadge()
        NotificationCenter.default.post(name: .init("cartUpdated"), object: product)
        addToCartAction?(product)
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
            
            addButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            addButton.heightAnchor.constraint(equalToConstant: 32)
            ,
            quantityBadge.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            quantityBadge.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            quantityBadge.widthAnchor.constraint(greaterThanOrEqualToConstant: 20),
            quantityBadge.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}


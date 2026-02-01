//
//  CategoryCardCell.swift
//  FoodPlanner
//
//  Created by Кирилл on 01.02.2026.
//

import UIKit

class CategoriesCardCell: UICollectionViewCell {
    
    var model: CategoriesCardModel? {
        didSet {
            bind()
        }
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let identifier = "CategoryCardCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        embedViews()
        setupStyle()
        setupLayout()
    }
    
    private func bind() {
            guard let model = model else { return }
            
            titleLabel.text = model.title
            imageView.image = model.image
            contentView.backgroundColor = model.color
            contentView.layer.borderColor = model.borderColor.cgColor
            contentView.layer.borderWidth = 1
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Embed views

private extension CategoriesCardCell {
    
    func embedViews() {
        contentView.addSubViews(imageView, titleLabel)
    }
    
}

// MARK: - Setup style

private extension CategoriesCardCell {
    
    func setupStyle() {
        layer.cornerRadius = 16
        layer.borderWidth = 2
        backgroundColor = .red
    }
    
}

// MARK: - Setup layout

private extension CategoriesCardCell {
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
}

//
//  CategoryCardCell.swift
//  FoodPlanner
//
//  Created by Кирилл on 01.02.2026.
//

import UIKit

class CategoryCardCell: UICollectionViewCell {
    
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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Embed views

private extension CategoryCardCell {
    
    func embedViews() {
        contentView.addSubViews(imageView, titleLabel)
    }
    
}

// MARK: - Setup style

private extension CategoryCardCell {
    
    func setupStyle() {
        layer.cornerRadius = 16
        layer.borderWidth = 2
        backgroundColor = .red
    }
    
}

// MARK: - Setup layout

private extension CategoryCardCell {
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            imageView.leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageView.trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageView.bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.topAnchor
                .constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}

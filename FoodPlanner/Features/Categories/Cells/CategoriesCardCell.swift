//
//  CategoryCardCell.swift
//  FoodPlanner
//
//  Created by Кирилл on 01.02.2026.
//

import UIKit

class CategoriesCardCell: UICollectionViewCell {

    // MARK: - Properties

    var model: CategoriesCardModel? {
        didSet {
            bind()
        }
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    static let identifier = "CategoryCardCell"

    private var imageTask: Task<Void, Never>?
    private var currentImageURL: URL?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        embedViews()
        setupStyle()
        setupLayout()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageTask?.cancel()
        imageTask = nil
        currentImageURL = nil
        imageView.image = nil
    }
    
    // MARK: - Private

    private func bind() {
        guard let model else { return }

        titleLabel.text = model.title
        backgroundColor = model.color
        layer.borderColor = model.borderColor.cgColor

        imageTask?.cancel()
        imageTask = nil

        imageView.image = model.image

        if let url = model.imageURL {
            currentImageURL = url
            imageTask = Task { [weak self] in
                guard let self else { return }
                let image = await ImageLoader.shared.loadImage(from: url)
                guard !Task.isCancelled, self.currentImageURL == url else { return }
                if let image {
                    self.imageView.image = image
                }
            }
        }
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
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
}

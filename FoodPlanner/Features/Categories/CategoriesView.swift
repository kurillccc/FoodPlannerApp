//
//  CategoriesView.swift
//  FoodPlanner
//
//  Created by Кирилл on 31.01.2026.
//

import UIKit

final class CategoriesView: UIView {

    // MARK: - Properties

    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Store"
        searchBar.searchBarStyle = .minimal
        searchBar.showsCancelButton = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView
            .register(
                CategoriesCardCell.self,
                forCellWithReuseIdentifier: CategoriesCardCell.identifier
            )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        embedViews()
        setupStyle()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
    
}

// MARK: - Embed views

private extension CategoriesView {
    
    func embedViews() {
        addSubViews(
            searchBar,
            collectionView,
            loadingIndicator
        )
    }
    
}

// MARK: - Setup style

private extension CategoriesView {
    
    func setupStyle() {
        backgroundColor = .systemBackground
    }
    
}

// MARK: - Setup layout

private extension CategoriesView {

    func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor
                .constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            searchBar.leadingAnchor
                .constraint(equalTo: leadingAnchor, constant: 20),
            searchBar.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            collectionView.leadingAnchor
                .constraint(equalTo: leadingAnchor, constant: 24),
            collectionView.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -24),
            collectionView.bottomAnchor
                .constraint(equalTo: bottomAnchor, constant: 8),

            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

}

// MARK: - Public

extension CategoriesView {

    func setLoading(_ isLoading: Bool) {
        if isLoading {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
}

#Preview {
    CategoriesView()
}

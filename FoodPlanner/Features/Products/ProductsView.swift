//
//  ProductsView.swift
//  FoodPlanner
//
//  Created by Кирилл on 01.02.2026.
//

import UIKit

final class ProductsView: UIView {
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Store"
        searchBar.searchBarStyle = .minimal
        searchBar.showsCancelButton = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.register(ProductsCardCell.self, forCellWithReuseIdentifier: ProductsCardCell.identifier)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        embedViews()
        setupStyle()
        setupLayout()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}

// MARK: - Embed views

private extension ProductsView {
    
    func embedViews() {
        addSubViews(
            searchBar,
            collectionView
        )
    }
    
}

// MARK: - Setup style

private extension ProductsView {
    
    func setupStyle() {
        backgroundColor = .systemBackground
    }
    
}

// MARK: - Setup layout

private extension ProductsView {

    func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8)
        ])
    }
    
}

#Preview {
    ProductsView()
}

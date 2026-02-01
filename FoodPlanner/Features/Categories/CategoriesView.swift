//
//  CategoriesView.swift
//  FoodPlanner
//
//  Created by Кирилл on 31.01.2026.
//

import UIKit

final class CategoriesView: UIView {
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Store"
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        embedViews()
        setupStyle()
        setupBehavior()
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
            collectionView
        )
    }
    
}

// MARK: - Setup style

private extension CategoriesView {
    
    func setupStyle() {
        backgroundColor = .white
    }
    
}

// MARK: - Setup behavior

private extension CategoriesView {
    
    func setupBehavior() {
        
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
                .constraint(equalTo: leadingAnchor, constant: 20),
            collectionView.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -20),
            collectionView.bottomAnchor
                .constraint(equalTo: bottomAnchor, constant: 8)
        ])
    }
    
}

#Preview {
    CategoriesView()
}

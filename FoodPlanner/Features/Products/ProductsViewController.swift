//
//  ProductsViewController.swift
//  FoodPlanner
//
//  Created by Кирилл on 01.02.2026.
//

import UIKit

final class ProductsViewController: UIViewController {
    
    private let productsView = ProductsView()
    private let viewModel: ProductsViewModel
    private var router: Router?
    
    init(categoryId: String, categoryTitle: String) {
        self.viewModel = ProductsViewModel(categoryId: categoryId)
        self.router = nil
        super.init(nibName: nil, bundle: nil)
        self.title = categoryTitle
    }

    convenience init() {
        self.init(router: nil)
    }

    init(router: Router?) {
        self.viewModel = ProductsViewModel(categoryId: "")
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        embedViews()
        setupDelegates()
        setupStyle()
        setupLayout()
    }
    
}

// MARK: - Embed views

private extension ProductsViewController {
    
    func embedViews() {
        view.addSubview(productsView)
    }
    
}

// MARK: - Setup Delegates

private extension ProductsViewController {
    
    func setupDelegates() {
        productsView.collectionView.delegate = self
        productsView.collectionView.dataSource = self
        productsView.searchBar.delegate = self
    }
    
}

// MARK: - Setup style

private extension ProductsViewController {
    
    func setupStyle() {
        view.backgroundColor = .systemBackground
    }
    
}

// MARK: - Setup layout

private extension ProductsViewController {

    func setupLayout() {
        productsView.pinToEdges(of: view)
    }
    
}

// MARK: - UICollectionViewDelegate

extension ProductsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

// MARK: - UICollectionViewDataSource

extension ProductsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductsCardCell.identifier,
            for: indexPath
        ) as? ProductsCardCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModel.item(at: indexPath))
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProductsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 2
        let spacing: CGFloat = 12
        let totalSpacing = spacing * (columns - 1)
        let width = (collectionView.bounds.width - totalSpacing) / columns
        return CGSize(width: width, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { 12 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { 12 }
    
}

// MARK: - UISearchBarDelegate

extension ProductsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filter(by: searchText)
        productsView.collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        viewModel.filter(by: nil)
        productsView.collectionView.reloadData()
        searchBar.resignFirstResponder()
    }
    
}

#Preview {
    let vc = ProductsViewController()
    return UINavigationController(rootViewController: vc)
}

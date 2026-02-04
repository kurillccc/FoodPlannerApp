//
//  CategoriesViewController.swift
//  FoodPlanner
//
//  Created by Кирилл on 31.01.2026.
//

import UIKit

final class CategoriesViewController: UIViewController {
    
    private let categoriesView = CategoriesView()
    private let viewModel = CategoriesViewModel()
    private var router: Router?
    
    private var allCategories: [CategoriesCardModel] = []
    private var filteredCategories: [CategoriesCardModel] = []
    
    convenience init() {
        self.init(router: nil)
    }
    
    init(router: Router?) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        embedViews()
        setupDelegates()
        setupLayout()
        setupNavigationController()
        
        allCategories = viewModel.categories
        filteredCategories = allCategories
    }
    
}

// MARK: - Embed views

private extension CategoriesViewController {
    
    func embedViews() {
        view.addSubview(categoriesView)
    }
    
}

// MARK: - Setup Delegates

private extension CategoriesViewController {
    
    func setupDelegates() {
        categoriesView.collectionView.delegate = self
        categoriesView.collectionView.dataSource = self
        
        categoriesView.searchBar.delegate = self
    }
    
}

// MARK: - Setup layout

private extension CategoriesViewController {

    func setupLayout() {
        categoriesView.pinToEdges(of: view)
    }
    
}

// MARK: - Setup navigation controller

private extension CategoriesViewController {
    
    func setupNavigationController() {
        title = "Find Products"
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
}

// MARK: - UICollectionViewDelegate

extension CategoriesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = viewModel.categories[indexPath.item]
        let categoryId = category.categoryId
        let vc = ProductsViewController(categoryId: categoryId, categoryTitle: category.title)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - UICollectionViewDataSource

extension CategoriesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCategories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoriesCardCell.identifier,
            for: indexPath
        ) as? CategoriesCardCell else {  return UICollectionViewCell() }

        let item = filteredCategories[indexPath.row]
        cell.model = item

        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    
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

extension CategoriesViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        if query.isEmpty {
            filteredCategories = allCategories
        } else {
            filteredCategories = allCategories.filter { model in
                model.title.range(of: query, options: [.caseInsensitive, .diacriticInsensitive]) != nil
            }
        }
        categoriesView.collectionView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        filteredCategories = allCategories
        categoriesView.collectionView.reloadData()
        searchBar.resignFirstResponder()
    }
}

#Preview {
    let vc = CategoriesViewController()
    return UINavigationController(rootViewController: vc)
}

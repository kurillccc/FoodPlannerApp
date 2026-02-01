//
//  CategoriesViewController.swift
//  FoodPlanner
//
//  Created by Кирилл on 31.01.2026.
//

import UIKit

final class CategoriesViewController: UIViewController {
    
    private let categoriesView = CategoriesView()
    private var router: Router?
    
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
    

    
}

// MARK: - UICollectionViewDataSource

extension CategoriesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCardCell.identifier,
            for: indexPath
        ) as? CategoryCardCell else {  return UICollectionViewCell() }
        
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    
    
    
}

#Preview {
    let vc = CategoriesViewController()
    return UINavigationController(rootViewController: vc)
}

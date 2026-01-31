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

// MARK: - Setup layout

private extension CategoriesViewController {
    
    func setupLayout() {
        
    }
    
}

// MARK: - Setup navigation controller

private extension CategoriesViewController {
    
    func setupNavigationController() {
        
    }
    
}

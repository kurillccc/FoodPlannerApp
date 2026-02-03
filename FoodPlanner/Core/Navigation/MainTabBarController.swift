//
//  MainTabBarController.swift
//  FoodPlanner
//
//  Created by Кирилл on 02.02.2026.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }

    private func setupTabs() {

        let categoriesNav = UINavigationController()
        let categoriesRouter = Router(navigation: categoriesNav)
        let categoriesVC = CategoriesViewController(router: categoriesRouter)

        categoriesNav.viewControllers = [categoriesVC]
        categoriesNav.tabBarItem = UITabBarItem(
            title: "Categories",
            image: UIImage(systemName: "list.bullet"),
            selectedImage: UIImage(systemName: "list.bullet")
        )

        let cartNav = UINavigationController()
        let cartVC = CartViewController()
        cartNav.viewControllers = [cartVC]
        cartNav.tabBarItem = UITabBarItem(
            title: "Basket",
            image: UIImage(systemName: "cart"),
            selectedImage: UIImage(systemName: "cart.fill")
        )

        viewControllers = [categoriesNav, cartNav]
    }
}

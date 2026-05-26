//
//  MainTabBarController.swift
//  FoodPlanner
//
//  Created by Кирилл on 02.02.2026.
//

import UIKit

final class MainTabBarController: UITabBarController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }

    // MARK: - Private

    private func setupTabs() {

        let categoriesNav = UINavigationController()
        categoriesNav.navigationBar.prefersLargeTitles = false
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

        let settingsNav = UINavigationController()
        settingsNav.navigationBar.prefersLargeTitles = false
        let settingsVC = SettingsViewController()
        settingsNav.viewControllers = [settingsVC]
        settingsNav.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape"),
            selectedImage: UIImage(systemName: "gearshape.fill")
        )

        viewControllers = [categoriesNav, cartNav, settingsNav]
    }
    
}

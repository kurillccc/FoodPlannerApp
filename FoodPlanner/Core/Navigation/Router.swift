//
//  Router.swift
//  FoodPlanner
//
//  Created by Кирилл on 30.01.2026.
//

import UIKit

final class Router {

    // MARK: - Properties

    private let navigation: UINavigationController

    // MARK: - Init

    init(navigation: UINavigationController) {
        self.navigation = navigation
    }

    // MARK: - Public

    func showMainFlow() {
        let tabBarController = MainTabBarController()
        navigation.setViewControllers([tabBarController], animated: true)
    }
}


//
//  Router.swift
//  FoodPlanner
//
//  Created by Кирилл on 30.01.2026.
//

import UIKit

final class Router {

    private let navigation: UINavigationController

    init(navigation: UINavigationController) {
        self.navigation = navigation
    }

    func showMainFlow() {
        let tabBarController = MainTabBarController()
        navigation.setViewControllers([tabBarController], animated: true)
    }
}


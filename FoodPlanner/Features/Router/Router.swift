//
//  Router.swift
//  FoodPlanner
//
//  Created by Кирилл on 30.01.2026.
//

import UIKit

final class Router {
    
    let navigation: UINavigationController
        
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    private func push(controller: UIViewController) {
        navigation.pushViewController(controller, animated: true)
    }
    
    private func pop() {
        navigation.popViewController(animated: true)
    }
    
}

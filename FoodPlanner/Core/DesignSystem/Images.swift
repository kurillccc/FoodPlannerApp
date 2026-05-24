//
//  Untitled.swift
//  FoodPlanner
//
//  Created by Кирилл on 30.01.2026.
//

import UIKit

struct Images {

    // MARK: - Welcome

    struct Welcome {
        static let logo = UIImage(named: "logo")!
        static let background = UIImage(named: "welcomeScreen")!
    }
    
    // MARK: - Category

    struct Category {
        static let bakery = UIImage(named: "bakery")!
        static let drinks = UIImage(named: "drinks")!
        static let milk = UIImage(named: "milk")!
        static let fruits = UIImage(named: "fruits")!
        static let meat = UIImage(named: "meat")!
        static let oils = UIImage(named: "oils")!
    }
    
    // MARK: - Products

    struct ProductImages {
        struct Bakery {
            static let baguette = UIImage(named: "baguette")!
            static let croissant = UIImage(named: "croissant")!
            static let bread = UIImage(named: "bread")!
            static let cookies = UIImage(named: "cookies")!
            static let donut = UIImage(named: "donut")!
            static let pie = UIImage(named: "pie")!
        }
        
        struct Drinks {
            static let cola = UIImage(named: "cola")!
            static let juice = UIImage(named: "juice")!
        }
    }
    
}

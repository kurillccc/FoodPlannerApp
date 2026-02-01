//
//  AppColor.swift
//  FoodPlanner
//
//  Created by Кирилл on 30.01.2026.
//

import UIKit

enum AppColor {

    enum Primary {
        static let main = UIColor(red: 84, green: 176, blue: 117, alpha: 1)
        static let description = UIColor(red: 252, green: 252, blue: 252, alpha: 0.7)
    }

    enum Card {

        enum FruitVeg {
            static let fill = UIColor(red: 84, green: 176, blue: 117, alpha: 0.1)
            static let stroke = UIColor(red: 84, green: 176, blue: 117, alpha: 0.7)
        }

        enum Oils {
            static let fill = UIColor(red: 247, green: 163, blue: 76, alpha: 0.1)
            static let stroke = UIColor(red: 247, green: 163, blue: 76, alpha: 0.7)
        }

        enum Meat {
            static let fill = UIColor(red: 247, green: 166, blue: 148, alpha: 0.25)
            static let stroke = UIColor(red: 247, green: 166, blue: 148, alpha: 1)
        }

        enum Bakery {
            static let fill = UIColor(red: 212, green: 176, blue: 224, alpha: 0.25)
            static let stroke = UIColor(red: 212, green: 176, blue: 224, alpha: 1)
        }

        enum Dairy {
            static let fill = UIColor(red: 252, green: 230, blue: 153, alpha: 0.25)
            static let stroke = UIColor(red: 252, green: 230, blue: 153, alpha: 1)
        }

        enum Drinks {
            static let fill = UIColor(red: 184, green: 222, blue: 245, alpha: 0.25)
            static let stroke = UIColor(red: 184, green: 222, blue: 245, alpha: 1)
        }
    }
    
}

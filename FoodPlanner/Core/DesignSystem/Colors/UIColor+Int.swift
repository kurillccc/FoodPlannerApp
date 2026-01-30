//
//  UIColor+Int.swift
//  FoodPlanner
//
//  Created by Кирилл on 30.01.2026.
//

import UIKit

extension UIColor {
    
    convenience init(
        red: Int,
        green: Int,
        blue: Int,
        alpha: CGFloat = 1
    ) {
        self.init(
            red: CGFloat(red) / 255,
            green: CGFloat(green) / 255,
            blue: CGFloat(blue) / 255,
            alpha: alpha
        )
    }
    
}

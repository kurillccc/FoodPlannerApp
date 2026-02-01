//
//  UIView+Extension.swift
//  FoodPlanner
//
//  Created by Кирилл on 30.01.2026.
//

import UIKit

extension UIView {
    
    func pinToEdges(of view: UIView, with constant: CGFloat = 0) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant)
        ])
    }
    
    func addSubViews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
    
}

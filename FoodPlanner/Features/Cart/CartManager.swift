//
//  CartManager.swift
//  FoodPlanner
//
//  Created by Кирилл on 02.02.2026.
//

import Foundation

final class CartManager {
    
    static let shared = CartManager()
    private init() {}
    
    private(set) var items: [CartItem] = []
    
    func add(product: ProductsModel) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(product: product, quantity: 1))
        }
        NotificationCenter.default.post(name: .init("cartUpdated"), object: nil)
    }
    
}

//
//  CartManager.swift
//  FoodPlanner
//
//  Created by Кирилл on 02.02.2026.
//

import Foundation

final class CartManager {

    // MARK: - Properties

    static let shared = CartManager()

    private let store = CartPersistenceStore.shared

    private(set) var items: [CartItem] = []

    // MARK: - Init

    private init() {
        items = store.loadItems()
    }

    // MARK: - Public

    func add(product: ProductsModel) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(product: product, quantity: 1))
        }

        store.save(items: items)
        NotificationCenter.default.post(name: .init("cartUpdated"), object: nil)
    }

    func remove(at index: Int) {
        guard items.indices.contains(index) else { return }
        items.remove(at: index)

        store.save(items: items)
        NotificationCenter.default.post(name: .init("cartUpdated"), object: nil)
    }

    func totalAmount() -> Decimal {
        items.reduce(0) { partial, item in
            let price = item.product.price ?? 0
            return partial + (price * Decimal(item.quantity))
        }
    }

}

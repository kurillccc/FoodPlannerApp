//
//  CartItemEntity.swift
//  FoodPlanner
//
//  Created by Кирилл on 24.05.2026.
//

import CoreData

@objc(CartItemEntity)
final class CartItemEntity: NSManagedObject {

    // MARK: - Properties

    @NSManaged var productId: String
    @NSManaged var title: String
    @NSManaged var categoryId: String
    @NSManaged var price: NSDecimalNumber?
    @NSManaged var quantity: Int64
    @NSManaged var imageData: Data?
}

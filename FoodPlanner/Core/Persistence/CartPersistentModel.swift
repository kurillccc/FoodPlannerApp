//
//  CartPersistentModel.swift
//  FoodPlanner
//
//  Created by Кирилл on 24.05.2026.
//

import CoreData

enum CartPersistentModel {

    // MARK: - Factory

    static func makeModel() -> NSManagedObjectModel {
        let model = NSManagedObjectModel()

        let entity = NSEntityDescription()
        entity.name = "CartItemEntity"
        entity.managedObjectClassName = NSStringFromClass(CartItemEntity.self)

        let productId = NSAttributeDescription()
        productId.name = "productId"
        productId.attributeType = .stringAttributeType
        productId.isOptional = false

        let title = NSAttributeDescription()
        title.name = "title"
        title.attributeType = .stringAttributeType
        title.isOptional = false

        let categoryId = NSAttributeDescription()
        categoryId.name = "categoryId"
        categoryId.attributeType = .stringAttributeType
        categoryId.isOptional = false

        let price = NSAttributeDescription()
        price.name = "price"
        price.attributeType = .decimalAttributeType
        price.isOptional = true

        let quantity = NSAttributeDescription()
        quantity.name = "quantity"
        quantity.attributeType = .integer64AttributeType
        quantity.isOptional = false

        let imageData = NSAttributeDescription()
        imageData.name = "imageData"
        imageData.attributeType = .binaryDataAttributeType
        imageData.isOptional = true
        imageData.allowsExternalBinaryDataStorage = true

        entity.properties = [productId, title, categoryId, price, quantity, imageData]
        model.entities = [entity]

        return model
    }
}

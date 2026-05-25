//
//  CartPersistenceStore.swift
//  FoodPlanner
//
//  Created by Кирилл on 24.05.2026.
//

import CoreData
import UIKit

final class CartPersistenceStore {

    // MARK: - Properties

    static let shared = CartPersistenceStore()
    private let stack = CoreDataStack.shared

    // MARK: - Init

    private init() {}

    // MARK: - Public

    func loadItems() -> [CartItem] {
        let request = NSFetchRequest<CartItemEntity>(entityName: "CartItemEntity")
        request.returnsObjectsAsFaults = false

        do {
            let entities = try stack.viewContext.fetch(request)
            return entities.compactMap { entity in
                let image: UIImage? = entity.imageData.flatMap { UIImage(data: $0) }

                let product = ProductsModel(
                    id: entity.productId,
                    title: entity.title,
                    image: image,
                    price: entity.price.map { Decimal(string: $0.stringValue) ?? 0 },
                    categoryId: entity.categoryId
                )

                return CartItem(product: product, quantity: Int(entity.quantity))
            }
        } catch {
            return []
        }
    }

    func save(items: [CartItem]) {
        let context = stack.viewContext

        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CartItemEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetch)
        deleteRequest.resultType = .resultTypeObjectIDs

        do {
            let result = try context.execute(deleteRequest) as? NSBatchDeleteResult
            if let objectIDs = result?.result as? [NSManagedObjectID], !objectIDs.isEmpty {
                let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: objectIDs]
                NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
            }
        } catch {
            // Ignore delete failures; we will try to overwrite anyway.
        }

        for item in items {
            guard let entity = NSEntityDescription.insertNewObject(forEntityName: "CartItemEntity", into: context) as? CartItemEntity else {
                continue
            }

            entity.productId = item.product.id
            entity.title = item.product.title
            entity.categoryId = item.product.categoryId
            entity.price = item.product.price.map { NSDecimalNumber(decimal: $0) }
            entity.quantity = Int64(item.quantity)
            entity.imageData = item.product.image?.pngData()
        }

        stack.saveContext()
    }
}

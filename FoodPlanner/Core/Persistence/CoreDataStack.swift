//
//  CoreDataStack.swift
//  FoodPlanner
//
//  Created by Кирилл on 24.05.2026.
//

import CoreData

final class CoreDataStack {

    // MARK: - Properties

    static let shared = CoreDataStack()

    let container: NSPersistentContainer

    var viewContext: NSManagedObjectContext {
        container.viewContext
    }

    // MARK: - Init

    private init() {
        let model = CartPersistentModel.makeModel()
        container = NSPersistentContainer(name: "FoodPlanner", managedObjectModel: model)

        container.loadPersistentStores { _, error in
            if let error {
                assertionFailure("Core Data store load failed: \(error)")
            }
        }

        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    // MARK: - Public

    func saveContext() {
        let context = container.viewContext
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            assertionFailure("Core Data save failed: \(error)")
        }
    }
}

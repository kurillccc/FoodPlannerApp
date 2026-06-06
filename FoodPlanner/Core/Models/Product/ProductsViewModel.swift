//
//  ProductsViewModel.swift
//  FoodPlanner
//
//  Created by Кирилл on 01.02.2026.
//

import Foundation

final class ProductsViewModel {

    // MARK: - Properties

    let categoryId: String

    private(set) var allProducts: [ProductsModel] = []
    private(set) var products: [ProductsModel] = []

    // MARK: - Init

    init(categoryId: String) {
        self.categoryId = categoryId
    }

    // MARK: - Public

    var numberOfItems: Int { products.count }

    func item(at index: Int) -> ProductsModel { products[index] }

    func filter(by query: String?) {
        let q = (query ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        if q.isEmpty {
            products = allProducts
        } else {
            products = allProducts.filter { $0.title.range(of: q, options: [.caseInsensitive, .diacriticInsensitive]) != nil }
        }
    }

    @MainActor
    func load() async {
        do {
            let dtos = try await StoreAPIClient.shared.fetchProducts(category: categoryId)
            let mapped: [ProductsModel] = dtos.map { dto in
                ProductsModel(
                    id: String(dto.id),
                    title: dto.title,
                    image: nil,
                    imageURL: URL(string: dto.image),
                    price: Decimal(dto.price),
                    categoryId: dto.category
                )
            }
            allProducts = mapped
            products = mapped
        } catch {
            allProducts = []
            products = []
        }
    }
}

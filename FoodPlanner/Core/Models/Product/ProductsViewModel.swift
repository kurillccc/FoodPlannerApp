//
//  ProductsViewModel.swift
//  FoodPlanner
//
//  Created by Кирилл on 01.02.2026.
//

import UIKit

final class ProductsViewModel {
    
    private let categoryId: String
    private let dataProvider: ProductsDataProvider
    
    private(set) var allProducts: [ProductsModel] = []
    private(set) var products: [ProductsModel] = []
    
    init(categoryId: String, dataProvider: ProductsDataProvider = MockProductsDataProvider()) {
        self.categoryId = categoryId
        self.dataProvider = dataProvider
        self.allProducts = dataProvider.loadProducts()
        self.products = allProducts.filter { $0.categoryId == categoryId }
    }
    
    var numberOfItems: Int { products.count }
    
    func item(at indexPath: IndexPath) -> ProductsModel { products[indexPath.item] }
    
    func filter(by query: String?) {
        let q = (query ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        if q.isEmpty {
            products = allProducts.filter { $0.categoryId == categoryId }
        } else {
            products = allProducts.filter { $0.categoryId == categoryId && $0.title.range(of: q, options: [.caseInsensitive, .diacriticInsensitive]) != nil }
        }
    }
    
}

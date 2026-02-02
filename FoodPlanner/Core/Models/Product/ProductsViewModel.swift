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
    
    private(set) var cart: [ProductsModel] = []
    
    init(categoryId: String, dataProvider: ProductsDataProvider = MockProductsDataProvider()) {
        self.categoryId = categoryId
        self.dataProvider = dataProvider
        
        switch categoryId {
        case "beverages":
            self.allProducts = dataProvider.beverageProducts()
        case "bakery":
            self.allProducts = dataProvider.bakeryProducts()
        default:
            self.allProducts = []
        }
        
        self.products = allProducts
    }
    
    var numberOfItems: Int { products.count }
    
    func item(at indexPath: IndexPath) -> ProductsModel { products[indexPath.item] }
    
    func filter(by query: String?) {
        let q = (query ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        if q.isEmpty {
            products = allProducts
        } else {
            products = allProducts.filter { $0.title.range(of: q, options: [.caseInsensitive, .diacriticInsensitive]) != nil }
        }
    }
    
    func addToCart(_ product: ProductsModel) {
        cart.append(product)
    }
}

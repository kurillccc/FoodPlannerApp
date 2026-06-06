//
//  ProductsModel.swift
//  FoodPlanner
//
//  Created by Кирилл on 01.02.2026.
//

import UIKit

struct ProductsModel {

    // MARK: - Properties

    let id: String
    let title: String
    let image: UIImage?
    let imageURL: URL?
    let price: Decimal?
    let categoryId: String
}

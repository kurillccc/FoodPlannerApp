//
//  ProductsDataProvider.swift
//  FoodPlanner
//
//  Created by Кирилл on 01.02.2026.
//

import UIKit

protocol ProductsDataProvider {
    func bakeryProducts() -> [ProductsModel]
    func beverageProducts() -> [ProductsModel]
}

struct MockProductsDataProvider: ProductsDataProvider {

    func bakeryProducts() -> [ProductsModel] {
        return [
            ProductsModel(
                id: "1",
                title: "French baguette",
                image: Images.ProductImages.Bakery.baguette,
                price: 110,
                categoryId: "bakery"
            ),
            ProductsModel(
                id: "2",
                title: "Chocolate croissant",
                image: Images.ProductImages.Bakery.croissant,
                price: 120,
                categoryId: "bakery"
            ),
            ProductsModel(
                id: "3",
                title: "Sliced bread",
                image: Images.ProductImages.Bakery.bread,
                price: 89,
                categoryId: "bakery"
            ),
            ProductsModel(
                id: "4",
                title: "Oatmeal cookies",
                image: Images.ProductImages.Bakery.cookies,
                price: 250,
                categoryId: "bakery"
            ),
            ProductsModel(
                id: "5",
                title: "Glazed donut",
                image: Images.ProductImages.Bakery.donut,
                price: 65,
                categoryId: "bakery"
            ),
            ProductsModel(
                id: "6",
                title: "Cherry pie",
                image: Images.ProductImages.Bakery.pie,
                price: 320,
                categoryId: "bakery"
            ),
            ProductsModel(
                id: "7",
                title: "Cherry pie",
                image: Images.ProductImages.Bakery.pie,
                price: 300,
                categoryId: "bakery"
            ),
            ProductsModel(
                id: "8",
                title: "Cherry pie",
                image: Images.ProductImages.Bakery.pie,
                price: 250,
                categoryId: "bakery"
            ),
            ProductsModel(
                id: "9",
                title: "Cherry pie",
                image: Images.ProductImages.Bakery.pie,
                price: 390,
                categoryId: "bakery"
            )
        ]
    }

    func beverageProducts() -> [ProductsModel] {
        return [
            ProductsModel(
                id: "7",
                title: "Cola",
                image: Images.ProductImages.Drinks.cola,
                price: 99,
                categoryId: "beverages"
            ),
            ProductsModel(
                id: "8",
                title: "Orange juice",
                image: Images.ProductImages.Drinks.juice,
                price: 180,
                categoryId: "beverages"
            )
        ]
    }
    
}



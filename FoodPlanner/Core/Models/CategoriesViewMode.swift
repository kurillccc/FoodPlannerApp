//
//  CategoriesViewMode.swift
//  FoodPlanner
//
//  Created by Кирилл on 01.02.2026.
//

import UIKit

struct CategoriesViewModel {
    
    let categories: [CategoriesCardModel]
    
    init() {
        self.categories = [
            CategoriesCardModel(
                title: "Bakery and Snacks",
                image: Images.Category.bakery,
                color: AppColor.Card.Bakery.fill,
                borderColor: AppColor.Card.Bakery.stroke
            ),
            CategoriesCardModel(
                title: "Frash Fruits & Vegetable",
                image: Images.Category.fruits,
                color: AppColor.Card.FruitVeg.fill,
                borderColor: AppColor.Card.FruitVeg.stroke
            ),
            CategoriesCardModel(
                title: "Dairy",
                image: Images.Category.milk,
                color: AppColor.Card.Dairy.fill,
                borderColor: AppColor.Card.Dairy.stroke
            ),
            CategoriesCardModel(
                title: "Meat",
                image: Images.Category.meat,
                color: AppColor.Card.Meat.fill,
                borderColor: AppColor.Card.Meat.stroke
            ),
            CategoriesCardModel(
                title: "Beverages",
                image: Images.Category.drinks,
                color: AppColor.Card.Drinks.fill,
                borderColor: AppColor.Card.Drinks.stroke
            ),
            CategoriesCardModel(
                title: "Bakery and Snacks",
                image: Images.Category.bakery,
                color: AppColor.Card.Bakery.fill,
                borderColor: AppColor.Card.Bakery.stroke
            ),
            CategoriesCardModel(
                title: "Cooking Oil & Ghee",
                image: Images.Category.oils,
                color: AppColor.Card.Oils.fill,
                borderColor: AppColor.Card.Oils.stroke
            ),
            CategoriesCardModel(
                title: "Dairy",
                image: Images.Category.milk,
                color: AppColor.Card.Dairy.fill,
                borderColor: AppColor.Card.Dairy.stroke
            ),
            CategoriesCardModel(
                title: "Meat",
                image: Images.Category.meat,
                color: AppColor.Card.Meat.fill,
                borderColor: AppColor.Card.Meat.stroke
            ),
            CategoriesCardModel(
                title: "Bakery and Snacks",
                image: Images.Category.bakery,
                color: AppColor.Card.Bakery.fill,
                borderColor: AppColor.Card.Bakery.stroke
            ),
            CategoriesCardModel(
                title: "Beverages",
                image: Images.Category.drinks,
                color: AppColor.Card.Drinks.fill,
                borderColor: AppColor.Card.Drinks.stroke
            ),
            CategoriesCardModel(
                title: "Bakery and Snacks",
                image: Images.Category.bakery,
                color: AppColor.Card.Bakery.fill,
                borderColor: AppColor.Card.Bakery.stroke
            )
        ]
        
    }
    
    // MARK: - Helper Methods
    
    var numberOfCategories: Int {
        categories.count
    }
    
    func category(at index: Int) -> CategoriesCardModel {
        categories[index]
    }
}

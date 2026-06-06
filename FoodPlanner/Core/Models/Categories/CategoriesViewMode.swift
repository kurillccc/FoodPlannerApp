//
//  CategoriesViewMode.swift
//  FoodPlanner
//
//  Created by Кирилл on 01.02.2026.
//

import UIKit

final class CategoriesViewModel {

    // MARK: - Properties

    private(set) var categories: [CategoriesCardModel] = []

    // MARK: - Public

    var numberOfCategories: Int {
        categories.count
    }

    func category(at index: Int) -> CategoriesCardModel {
        categories[index]
    }

    @MainActor
    func loadCategories() async {
        do {
            let names = try await StoreAPIClient.shared.fetchCategories()

            let mapped = await withTaskGroup(of: CategoriesCardModel.self) { group in
                for name in names {
                    group.addTask {
                        let coverURL: URL? = (try? await StoreAPIClient.shared.fetchProducts(category: name).first)
                            .flatMap { URL(string: $0.image) }

                        return CategoriesCardModel(
                            categoryId: name,
                            title: self.formatCategoryTitle(name),
                            image: self.categoryImage(name),
                            imageURL: coverURL,
                            color: self.categoryColors(name).fill,
                            borderColor: self.categoryColors(name).stroke
                        )
                    }
                }

                var result: [CategoriesCardModel] = []
                result.reserveCapacity(names.count)
                for await model in group {
                    result.append(model)
                }
                return result.sorted { $0.title < $1.title }
            }

            categories = mapped
        } catch {
            categories = []
        }
    }

    // MARK: - Private

    private func formatCategoryTitle(_ raw: String) -> String {
        raw
            .replacingOccurrences(of: "\"", with: "")
            .replacingOccurrences(of: "'", with: "’")
            .capitalized
    }

    private func categoryImage(_ category: String) -> UIImage {
        let key = category.lowercased()
        switch key {
        case "electronics":
            return UIImage(systemName: "tv") ?? UIImage()
        case "jewelery":
            return UIImage(systemName: "sparkles") ?? UIImage()
        case "men’s clothing", "men's clothing":
            return UIImage(systemName: "tshirt") ?? UIImage()
        case "women’s clothing", "women's clothing":
            return UIImage(systemName: "tshirt.fill") ?? UIImage()
        default:
            return UIImage(systemName: "cart") ?? UIImage()
        }
    }

    private func categoryColors(_ category: String) -> (fill: UIColor, stroke: UIColor) {
        let key = category.lowercased()
        switch key {
        case "electronics":
            return (AppColor.Card.Drinks.fill, AppColor.Card.Drinks.stroke)
        case "jewelery":
            return (AppColor.Card.Oils.fill, AppColor.Card.Oils.stroke)
        case "men’s clothing", "men's clothing":
            return (AppColor.Card.Meat.fill, AppColor.Card.Meat.stroke)
        case "women’s clothing", "women's clothing":
            return (AppColor.Card.Bakery.fill, AppColor.Card.Bakery.stroke)
        default:
            return (AppColor.Card.FruitVeg.fill, AppColor.Card.FruitVeg.stroke)
        }
    }
}

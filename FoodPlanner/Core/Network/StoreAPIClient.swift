//
//  StoreAPIClient.swift
//  FoodPlanner
//
//  Created by Кирилл on 27.05.2026.
//

import Foundation

final class StoreAPIClient {

    // MARK: - Properties

    static let shared = StoreAPIClient()

    private let baseURL = URL(string: "https://fakestoreapi.com")!
    private let session: URLSession

    // MARK: - Init

    init(session: URLSession = .shared) {
        self.session = session
    }

    // MARK: - Public

    func fetchCategories() async throws -> [String] {
        let url = baseURL.appending(path: "products/categories")
        let (data, response) = try await session.data(from: url)
        try validateHTTP(response)
        return try JSONDecoder().decode([String].self, from: data)
    }

    func fetchProducts(category: String) async throws -> [StoreProductDTO] {
        var allowed = CharacterSet.urlPathAllowed
        allowed.remove(charactersIn: "'")

        let encodedCategory = category.addingPercentEncoding(withAllowedCharacters: allowed) ?? category
        let urlString = baseURL.absoluteString + "/products/category/" + encodedCategory
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await session.data(from: url)
        try validateHTTP(response)
        return try JSONDecoder().decode([StoreProductDTO].self, from: data)
    }

    // MARK: - Private

    private func validateHTTP(_ response: URLResponse) throws {
        guard let http = response as? HTTPURLResponse else { return }
        guard (200...299).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
}

struct StoreProductDTO: Decodable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
}

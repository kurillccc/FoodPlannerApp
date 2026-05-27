//
//  ImageLoader.swift
//  FoodPlanner
//
//  Created by Кирилл on 27.05.2026.
//

import UIKit

final class ImageLoader {

    // MARK: - Properties

    static let shared = ImageLoader()

    private let cache = NSCache<NSURL, UIImage>()

    // MARK: - Init

    private init() {}

    // MARK: - Public

    func loadImage(from url: URL?) async -> UIImage? {
        guard let url else { return nil }

        if let cached = cache.object(forKey: url as NSURL) {
            return cached
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
                return nil
            }
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: url as NSURL)
            return image
        } catch {
            return nil
        }
    }
}

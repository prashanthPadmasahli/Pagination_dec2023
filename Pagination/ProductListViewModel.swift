//
//  Models.swift
//  Pagination
//
//  Created by mac on 30/12/23.
//

import Foundation

class ProductListViewModel: ObservableObject {
    
    @MainActor
    func fetchProducts(_ pageNumber: Int) async -> [Product] {
        guard let url = URL(string: "https://dummyjson.com/products?skip=\(30*pageNumber)"),
              let (data, _) = try? await URLSession.shared.data(from: url),
              let productList = try? JSONDecoder().decode(ProductList.self, from: data) else {
            return []
        }
        return productList.products
    }
}


struct ProductList: Decodable {
    let products: [Product]
}

struct Product: Decodable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let thumbnail: String
}

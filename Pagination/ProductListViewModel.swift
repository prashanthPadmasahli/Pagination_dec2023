//
//  Models.swift
//  Pagination
//
//  Created by mac on 30/12/23.
//

import Foundation

class ProductListViewModel: ObservableObject {
    let itemsPerPage = 10
    
    @MainActor
    func fetchProducts(_ pageNumber: Int = 0) async -> [Product] {
        // https://dummyjson.com/products?limit=20&skip=10
        guard let url = URL(string: "https://dummyjson.com/products?limit=\(itemsPerPage)&skip=\(itemsPerPage*pageNumber)"),
              let (data, _) = try? await URLSession.shared.data(from: url),
              let productList = try? JSONDecoder().decode(ProductList.self, from: data) else {
            return []
        }
        return productList.products
    }
}

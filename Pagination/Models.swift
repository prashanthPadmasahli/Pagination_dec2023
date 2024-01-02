//
//  Models.swift
//  Pagination
//
//  Created by mac on 02/01/24.
//

import Foundation

struct ProductList: Decodable {
    let products: [Product]
}

struct Product: Decodable, Identifiable, Equatable {
    let id: Int
    let title: String
    let description: String
    let thumbnail: String
}

//
//  ContentView.swift
//  Pagination
//
//  Created by mac on 30/12/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ProductListViewModel()
    @State var products = [Product]()
    @State var pageNumber = 0
    
    var body: some View {
        NavigationStack {
            List(products) { product in
                productRow(product)
                    .task {
                        if product == products.last {
                            pageNumber += 1
                            products += await viewModel.fetchProducts(pageNumber)
                        }
                    }
            }
            .navigationTitle("Products")
            .task {
                products = await viewModel.fetchProducts()
            }
            .refreshable {
                products = await viewModel.fetchProducts().shuffled()
                pageNumber = 0
            }
        }
    }
    
    func productRow(_ product: Product) -> some View {
        HStack {
            asyncImage(imageUrl: product.thumbnail)
            VStack(alignment: .leading) {
                Text(product.title)
                    .bold()
                Text(product.description)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }
        }
    }
    
    func asyncImage(imageUrl: String) -> some View {
        AsyncImage(url: URL(string: imageUrl)!) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            ProgressView()
        }
        .frame(width: 100, height: 100)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

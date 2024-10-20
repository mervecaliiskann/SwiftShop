//
//  ProductViewModel.swift
//  SwiftShop
//
//  Created by Merve Çalışkan on 7.10.2024.
//

import Foundation
import Kingfisher

final class ProductVM {
    
    private var products: [Product] = []
    
     var sections: [SectionProduct] = [
        SectionProduct(title: "Aksesuar", products:[]),
        SectionProduct(title: "Kozmetik", products: []),
        SectionProduct(title: "Teknoloji", products: [])
    ]
    private var filteredSections: [SectionProduct] = []
    private let serviceManager: Networkable
    var isFiltering: Bool = false
    init(serviceManager: Networkable) {
        self.serviceManager = serviceManager
    }
    
    func fetchProducts(completion: @escaping () -> ()) {
        serviceManager.fetchData(endpoint: MainEndpoint.tumUrunler, body: nil) { [weak self] (result: Result<ProductResponse, Error>) in
            switch result {
            case .success(let response):
                self?.addProductsToSections(products: response.urunler)
                self?.filteredSections = self?.sections ?? []
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func addProductsToSections(products: [Product]) {
        for product in products {
            if product.category == "Aksesuar" {
                if let index = sections.firstIndex(where: { $0.title == "Aksesuar" }) {
                    self.sections[index].products.append(product)
                }
            } else if product.category == "Kozmetik" {
                if let index = sections.firstIndex(where: { $0.title == "Kozmetik" }) {
                    sections[index].products.append(product)
                }
            }else if product.category == "Teknoloji" {
                if let index = sections.firstIndex(where: { $0.title == "Teknoloji" }) {
                    sections[index].products.append(product)
                }
            }
        }
    }
    
    func filterProducts(by searchText: String) {
        if searchText.isEmpty {
            filteredSections = sections
        } else {
            filteredSections = sections.compactMap { section in
                let filteredProducts = section.products.filter {
                    $0.name.lowercased().contains(searchText.lowercased())
                }
                return filteredProducts.isEmpty ? nil : SectionProduct(title: section.title, products: filteredProducts)
            }
        }
    }
    
    
    var currentSections: [SectionProduct] {
        return isFiltering ? filteredSections : sections
    }
}

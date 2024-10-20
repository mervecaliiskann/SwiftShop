//
//  ProductsUserDefaults.swift
//  SwiftShop
//
//  Created by Merve Çalışkan on 19.10.2024.
//

import Foundation

final class ProductsUserDefaults {
    static let shared = ProductsUserDefaults()
    var productList: [Product] = [] {
        didSet {
            saveProducts(productList)
        }
    }
    private let userDefaults = UserDefaults.standard
    private let productKey = "savedProduct"
    
    private init() { }
    
    func saveProducts(_ products: [Product]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(products)
            userDefaults.set(data, forKey: productKey)
        } catch {
            print(error)
        }
    }
    
    func getProducts(completion: ([Product]) -> ()) {
        guard let data = userDefaults.data(forKey: productKey) else {
            completion([])
            return
        }
        do {
            let decoder = JSONDecoder()
            let products = try decoder.decode([Product].self, from: data)
            completion(products)
        } catch {
            completion([])
        }
    }
}

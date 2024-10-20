//
//  Product.swift
//  SwiftShop
//
//  Created by Merve Çalışkan on 7.10.2024.
//

import Foundation

struct ProductResponse: Codable {
    let urunler: [Product]
    let success: Int
}

struct Product: Codable {
    let id: Int
    let name: String
    let price: Int
    let category: String
    let imageUrl: String
    let brand: String
     
    enum CodingKeys: String, CodingKey {
        case id
        case name = "ad"
        case price = "fiyat"
        case category = "kategori"
        case imageUrl = "resim"
        case brand = "marka"
    }
}


//
//  CartItem.swift
//  SwiftShop
//
//  Created by Merve Çalışkan on 9.10.2024.
//

import Foundation

struct CartItem: Codable {
    var sepetId: Int
    var ad: String
    var resim: String
    var kategori: String
    var fiyat: Int
    var marka: String
    var siparisAdeti: Int
    var kullaniciAdi: String
}

struct ProductKey: Hashable {
    let ad: String
    let marka: String
}

struct GroupedCartItem {
    var ad: String
    var marka: String
    var resim: String
    var kategori: String
    var fiyat: Int
    var siparisAdeti: Int
    var kullaniciAdi: String
    var sepetIds: [Int]
}


struct CartResponse: Codable {
    var urunlerSepeti: [CartItem]
    var success: Int
    
    enum CodingKeys: String, CodingKey {
        case urunlerSepeti = "urunler_sepeti"  
        case success = "success"
    }
}

struct AddToCartResponse: Decodable {
    let success: Int
    let message: String
}

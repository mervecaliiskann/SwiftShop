//
//  ProductDetailVM.swift
//  SwiftShop
//
//  Created by Merve Çalışkan on 14.10.2024.
//

import Foundation

final class ProductDetailVM {
    
    private let serviceManager: Networkable
     var siparisAdeti: Int = 0
    
    init(serviceManager: Networkable) {
        self.serviceManager = serviceManager
    }

     func addToCart(product: Product, completion: @escaping (Bool) -> ()) {
        let productRequest = ProductToCartRequest(
            ad: product.name,
            resim: product.imageUrl,
            kategori: product.category,
            fiyat: product.price,
            marka: product.brand,
            siparisAdeti: siparisAdeti,
            kullaniciAdi: "MERVE_CALISKAN"
        )

        serviceManager.fetchData(endpoint: DetailEndpoint.urunSepeteEkle, body: productRequest) { (result: Result<AddToCartResponse, Error>) in
            switch result {
            case .success(let response):
                print(response.message)
                completion(true)
            case .failure(let error):
                print("Hata: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
}

struct ProductToCartRequest: Encodable {
    let ad: String
    let resim: String
    let kategori: String
    let fiyat: Int
    let marka: String
    let siparisAdeti: Int
    let kullaniciAdi: String
}

//
//  CartViewModel.swift
//  SwiftShop
//
//  Created by Merve Çalışkan on 9.10.2024.
//

import Foundation
import Kingfisher

final class CartVM {
    
     var cartItems: [GroupedCartItem] = []
    private let serviceManager: Networkable
    
    init(serviceManager: Networkable) {
        self.serviceManager = serviceManager
    }

    func getCartItems() -> [GroupedCartItem] {
        return cartItems
    }

     func fetchCartItems(completion: @escaping (Bool) -> Void) {
        serviceManager.fetchData(endpoint: CartEndpoint.urunleriGetir, body: CartRequest(kullaniciAdi: "MERVE_CALISKAN")) { [weak self] (result: Result<CartResponse, Error>) in
            switch result {
            case .success(let response):
                guard let grouped = self?.groupCartItemsByAdAndMarka(cartItems: response.urunlerSepeti) else { return }
                self?.cartItems = grouped.sorted(by: { $0.ad < $1.ad })
                DispatchQueue.main.async {
                    completion(true)
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }

    private func combineSameProducts(_ cartItems: [CartItem]) -> [CartItem] {
        return Dictionary(grouping: cartItems, by: { ProductKey(ad: $0.ad, marka: $0.marka) })
            .map { (key, items) -> CartItem in
                var firstItem = items.first!
                firstItem.siparisAdeti = items.reduce(0) { $0 + $1.siparisAdeti }
                return firstItem
            }
    }
    
    private func groupCartItemsByAdAndMarka( cartItems: [CartItem]) -> [GroupedCartItem] {
        return Dictionary(grouping: cartItems, by: { ProductKey(ad: $0.ad, marka: $0.marka) })
            .map { (key, items) -> GroupedCartItem in
                let firstItem = items.first!
                let toplamSiparisAdeti = items.reduce(0) { $0 + $1.siparisAdeti }
                let sepetIds = items.map { $0.sepetId }
                
                return GroupedCartItem(
                    ad: firstItem.ad,
                    marka: firstItem.marka,
                    resim: firstItem.resim,
                    kategori: firstItem.kategori,
                    fiyat: firstItem.fiyat,
                    siparisAdeti: toplamSiparisAdeti,
                    kullaniciAdi: firstItem.kullaniciAdi,
                    sepetIds: sepetIds
                )
            }
    }

     func removeProductFromCart(productId: Int, completion: @escaping (Bool) -> Void) {
        let request = ProductRemove(sepetId: productId, kullaniciAdi: "MERVE_CALISKAN")
        
        serviceManager.fetchData(endpoint: CartEndpoint.urunleriSil, body: request) { (result: Result<ProductRemoveResponse, Error>) in
            switch result {
            case .success:
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}
struct CartRequest: Encodable {
    let kullaniciAdi: String
}

struct ProductRemove: Encodable {
    let sepetId: Int
    let kullaniciAdi: String
}

struct ProductRemoveResponse: Decodable {
    let success: Int
    let message: String
}

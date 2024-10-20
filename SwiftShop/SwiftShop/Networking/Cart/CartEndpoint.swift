//
//  CartEndpoint.swift
//  SwiftShop
//
//  Created by Merve Çalışkan on 15.10.2024.
//

import Foundation

enum CartEndpoint: Endpointable {
    case urunleriGetir
    case urunleriSil
    
    var baseUrl: String {
        return "http://kasimadalan.pe.hu/urunler"
    }
    
    var fullPath: String {
        return self.baseUrl + self.rawValue
    }
    
    var rawValue: String {
        switch self {
        case .urunleriGetir:
            return "/sepettekiUrunleriGetir.php"
        case .urunleriSil:
            return "/sepettenUrunSil.php"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .POST
    }
}

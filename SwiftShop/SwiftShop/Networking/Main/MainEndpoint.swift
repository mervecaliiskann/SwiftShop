//
//  MainEndpoint.swift
//  SwiftShop
//
//  Created by Merve Çalışkan on 15.10.2024.
//

import Foundation

enum MainEndpoint: Endpointable {
    case tumUrunler
    
    var baseUrl: String {
        return "http://kasimadalan.pe.hu/urunler"
    }
    
    var fullPath: String {
        return self.baseUrl + self.rawValue
    }
    
    var rawValue: String {
        switch self {
        case .tumUrunler:
            return "/tumUrunleriGetir.php"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .tumUrunler:
            return .GET
        }
    }
}

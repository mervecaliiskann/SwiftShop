//
//  DetailEndpoint.swift
//  SwiftShop
//
//  Created by Merve Çalışkan on 15.10.2024.
//

import Foundation

enum DetailEndpoint: Endpointable {
    case urunSepeteEkle
    
    var baseUrl: String {
        return "http://kasimadalan.pe.hu/urunler"
    }
    
    var fullPath: String {
        return self.baseUrl + self.rawValue
    }
    
    var rawValue: String {
        switch self {
        case .urunSepeteEkle:
            return "/sepeteUrunEkle.php"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .urunSepeteEkle:
            return .POST
        }
    }
}

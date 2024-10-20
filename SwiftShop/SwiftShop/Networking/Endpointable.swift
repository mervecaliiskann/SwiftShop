//
//  Endpointable.swift
//  SwiftShop
//
//  Created by Merve Çalışkan on 14.10.2024.
//

import Foundation

protocol Endpointable {
    var baseUrl: String { get }
    var fullPath: String { get }
    var rawValue: String { get }
    var httpMethod: HTTPMethod { get }
}

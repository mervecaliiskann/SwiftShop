//
//  Networkable.swift
//  SwiftShop
//
//  Created by Merve Çalışkan on 14.10.2024.
//

import Foundation

protocol Networkable {
    func fetchData<T: Decodable>(
        endpoint: Endpointable,
        body: Encodable?,
        completion: @escaping (Result<T, Error>) -> ()
    )
}

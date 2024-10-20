//
//  URLSessionServiceManager.swift
//  SwiftShop
//
//  Created by Merve Çalışkan on 14.10.2024.
//

import Foundation

final class URLSessionServiceManager: Networkable {
    
    func fetchData<T>(endpoint: any Endpointable, body: Encodable? = nil, completion: @escaping (Result<T, any Error>) -> ()) where T : Decodable {
        var components = URLComponents(string: endpoint.fullPath)
        
        guard let url = components?.url else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue

        if let body {
            if endpoint.httpMethod == .POST {
                if let queryItems = encodeToURLQueryItem(body) {
                    components?.queryItems = queryItems
                    request.httpBody = components?.query?.data(using: .utf8)
                }
            }
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                print(error)
            } else {
                guard let data else { return }
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(T.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    func encodeToURLQueryItem<T: Encodable>(_ encodable: T) -> [URLQueryItem]? {
        let mirror = Mirror(reflecting: encodable)
        var queryItems: [URLQueryItem] = []
        for child in mirror.children {
            if let key = child.label {
                let value = "\(child.value)"
                let queryItem = URLQueryItem(name: key, value: value)
                queryItems.append(queryItem)
            }
        }
        print(queryItems)
        return queryItems
    }
}

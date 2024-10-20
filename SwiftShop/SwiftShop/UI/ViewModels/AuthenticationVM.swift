//
//  AuthenticationViewModel.swift
//  SwiftShop
//
//  Created by Merve Çalışkan on 18.10.2024.
//

import Foundation
import FirebaseAuth

final class AuthenticationVM {
    
    private func checkIfEmailExists(email: String, completion: @escaping (Bool, String?) -> Void) {
        Auth.auth().fetchSignInMethods(forEmail: email) { methods, error in
            if let error = error {
                completion(false, error.localizedDescription)
            } else if let methods = methods, !methods.isEmpty {
                completion(true, nil)
            } else {
                completion(false, "Bu e-posta kayıtlı değil. Lütfen farklı bir e-posta deneyin.")
            }
        }
    }
    
     func register(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        AuthenticationService.shared.registerUser(email: email, password: password) { result in
            switch result {
            case .success:
                completion(true, nil)
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
    
     func login(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .wrongPassword:
                    completion(false, "Yanlış şifre. Lütfen tekrar deneyin.")
                case .userNotFound:
                    completion(false, "Bu e-postaya sahip kullanıcı bulunamadı. Lütfen önce kaydolun.")
                case .invalidEmail:
                    completion(false, "Geçersiz e-posta biçimi.")
                default:
                    completion(false, error.localizedDescription)
                }
            } else if let user = authResult?.user {
                completion(true, nil)
            }
        }
    }
    
    private func logout(completion: @escaping (Bool, String?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true, nil)
        } catch let error {
            completion(false, error.localizedDescription)
        }
    }
}

//
//  AccountViewController.swift
//  SwiftShop
//
//  Created by Merve Çalışkan on 19.10.2024.
//

import UIKit
import FirebaseAuth

final class AccountVC: UIViewController {
    
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    
    private let viewModel = AuthenticationVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .systemGreen
        loadUserDetails()
        
    }
    
    private func navigateToLoginScreen() {
        performSegue(withIdentifier: "goToLog", sender: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
    
    private func loadUserDetails() {
        if let user = Auth.auth().currentUser {
            headerLabel.text = "Hoş geldin\n\(user.email ?? "Kullanıcı")!"
        } else {
            headerLabel.text = "Giriş yapmadınız."
        }
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            navigateToLoginScreen()
        } catch let error {
            showAlert(title: "Hata", message: "Çıkış yaparken bir sorun oluştu.")
        }
    }
    
}

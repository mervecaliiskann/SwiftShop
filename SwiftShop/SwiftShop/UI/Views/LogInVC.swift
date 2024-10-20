//
//  LogInVC.swift
//  SwiftShop
//
//  Created by Merve Çalışkan on 17.10.2024.
//

import UIKit

final class LogInVC: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var logInLabel: UILabel!
    @IBOutlet private weak var logInSubTitleLabel: UILabel!
    @IBOutlet private weak var eMailTf: UITextField!
    @IBOutlet private weak var passwordTf: UITextField!
    
    
    private let viewModel = AuthenticationVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    }

    private func showError(_ message: String) {
        let alert = UIAlertController(title: "HATA", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "TAMAM", style: .default))
        present(alert, animated: true)
    }

    @IBAction func logInButton(_ sender: Any) {
        guard let email = eMailTf.text, !email.isEmpty,
              let password = passwordTf.text, !password.isEmpty else {
            showError("Lütfen hem e-postayı hem de şifreyi girin.")
            return
        }

        viewModel.login(email: email, password: password) { [weak self] success, error in
            if success {
                self?.performSegue(withIdentifier: "goToProduct", sender: nil)
            } else if let errorMessage = error {
                self?.showError(errorMessage)
            }
        }
    }
    
    @IBAction func newSignInButton(_ sender: Any) {
        performSegue(withIdentifier: "goToSign", sender: self)
    }
    
    @IBAction func forgottPasswordButton(_ sender: Any) {
        let alert = UIAlertController(title: "Şifreni mi unuttun?",
                                      message: "Lütfen şifrenizi sıfırlayın.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "TAMAM", style: .default, handler: { [weak self] _ in
            self?.performSegue(withIdentifier: "goToForgotPassword", sender: nil)
        }))
        
        present(alert, animated: true)
    }
}

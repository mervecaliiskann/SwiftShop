//
//  SignInViewController.swift
//  SwiftShop
//
//  Created by Merve Çalışkan on 17.10.2024.
//

import UIKit
import FirebaseAuth

final class SignInVC: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var signInLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    @IBOutlet private weak var eMailTf: UITextField!
    @IBOutlet private weak var passwordTf: UITextField!
    
    private let viewModel = AuthenticationVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    }
    
    
    private func navigateToLogin() {
        let loginVC = LogInVC()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "HATA", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "TAMAM", style: .default))
        present(alert, animated: true)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
    
    @IBAction func signInButton(_ sender: Any) {
        guard let email = eMailTf.text, let password = passwordTf.text else { return }
        
        if !isValidEmail(email) {
            showError("Lütfen geçerli bir E-mail giriniz!")
            return
        }
        
        if password.count < 6 {
            showError("Şifre en az 6 karakter uzunluğunda olmalıdır.")
            return
        }
        
        viewModel.register(email: email, password: password) { [weak self] success, error in
            if success {
                self?.performSegue(withIdentifier: "goToLogin", sender: self)
            } else if let errorMessage = error {
                self?.showError(errorMessage)
            }
        }
    }
    
    @IBAction func logInButton(_ sender: Any) {
        performSegue(withIdentifier: "goToLogin", sender: self)
    }
}

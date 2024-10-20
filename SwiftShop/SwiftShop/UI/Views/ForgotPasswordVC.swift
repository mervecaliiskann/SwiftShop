//
//  ForgotPasswordViewController.swift
//  SwiftShop
//
//  Created by Merve Çalışkan on 17.10.2024.
//

import UIKit
import FirebaseAuth

final class ForgotPasswordVC: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var forgotPasswordLabel: UILabel!
    @IBOutlet private weak var forgotPasswordSubTitleLabel: UILabel!
    @IBOutlet private weak var eMailTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.systemGreen
        
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "HATA", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "TAMAM", style: .default))
        present(alert, animated: true)
    }
    
    private func showSuccess(_ message: String) {
        let alert = UIAlertController(title: "BAŞARILI", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }
    
    @IBAction func senderButton(_ sender: Any) {
        guard let email = eMailTf.text, !email.isEmpty else {
            showError("Lütfen e-posta adresinizi giriniz.")
            return
        }
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            if let error = error {
                self?.showError("Error: \(error.localizedDescription)")
            } else {
                self?.showSuccess("\(email) adresine bir şifre sıfırlama bağlantısı gönderildi. Lütfen gelen kutunuzu kontrol edin.")
            }
        }
    }
}

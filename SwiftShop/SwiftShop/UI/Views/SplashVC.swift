//
//  SplashVC.swift
//  SwiftShop
//
//  Created by Merve Çalışkan on 17.10.2024.
//

import UIKit
import FirebaseAuth

final class SplashVC: UIViewController {
    
    @IBOutlet private weak var startLabelSS: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startLabelSS.alpha = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            UIView.animate(withDuration: 3.0, animations: {
                self?.startLabelSS.alpha = 1
            }, completion: { _ in
                self?.checkUserSession()
            })
        }
    }
    
    private func checkUserSession() {
        self.performSegue(withIdentifier: "goToSign", sender: nil)
    }
}

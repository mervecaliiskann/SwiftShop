//
//  ProductDetailViewController.swift
//  SwiftShop
//
//  Created by Merve Çalışkan on 7.10.2024.
//

import UIKit
import Kingfisher

final class ProductDetailVC: UIViewController {
    
    @IBOutlet private weak var productStackView: UIStackView!
    @IBOutlet private weak var imageDetail: UIImageView!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var brandLabel: UILabel!
    @IBOutlet private weak var productCountLabel: UILabel!
    
     var product: Product?
    private let viewModel = ProductDetailVM(serviceManager: URLSessionServiceManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .systemGreen
        setupProductDetails()
    }
    
    private func setupProductDetails() {
        guard let product = product else { return }
        nameLabel.attributedText = createAttributedText(baslik: "Ad: ", icerik: product.name)
        priceLabel.attributedText = createAttributedText(baslik: "Fiyat: ", icerik: "\(product.price) ₺")
        brandLabel.attributedText = createAttributedText(baslik: "Marka: ", icerik: product.brand)
        categoryLabel.attributedText = createAttributedText(baslik: "Kategori: ", icerik: product.category)
        
        if let imageUrl = URL(string: "http://kasimadalan.pe.hu/urunler/resimler/\(product.imageUrl)") {
            imageDetail.kf.setImage(with: imageUrl)
        }
        productStackView.layoutIfNeeded()
    }
    
    private func createAttributedText(baslik: String, icerik: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString (
            string: baslik,
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 18),
                .foregroundColor: UIColor.black
            ]
        )
        let icerikString = NSAttributedString (
            string: icerik,
            attributes: [
                .font: UIFont.systemFont(ofSize: 16),
                .foregroundColor: UIColor.systemGreen
            ]
        )
        attributedString.append(icerikString)
        return attributedString
    }
    
    @IBAction func didTappedProductCountStepper(_ sender: UIStepper) {
        productCountLabel.text = "\(Int(sender.value).description)"
        viewModel.siparisAdeti = Int(sender.value)
        
    }
    @IBAction func addToCardButton(_ sender: Any) {
        guard let product = product else { return }
        viewModel.addToCart(product: product) { success in
            let message = success ? "\(product.name) sepete eklendi." : "Ürün sepete eklenemedi."
            let alert = UIAlertController(title: success ? "Başarılı" : "Hata", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Tamam", style: .default) { _ in
                if success {
                    self.performSegue(withIdentifier: "cartShow", sender: self)
                }
            }
            alert.addAction(action)
            DispatchQueue.main.async {
                self.present(alert, animated: true)
            }
        }
    }
}

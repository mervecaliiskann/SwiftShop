//
//  ProductsCell.swift
//  SwiftShop
//
//  Created by Merve Çalışkan on 8.10.2024.
//

import UIKit


protocol ProductsCellDelegate: AnyObject {
    func didTapDetailButton(for product: Product)
}

final class ProductsCell: UITableViewCell {
    
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productPriceLabel: UILabel!
    @IBOutlet private weak var productButton: UIButton!
    @IBOutlet private weak var productBrandLabel: UILabel!
    
    weak var delegate: ProductsCellDelegate?
    var product: Product?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
     func prepareCell(with model: Product) {
        product = model
        productBrandLabel.text = model.brand
        productNameLabel.text = model.name
        productPriceLabel.text = "\(model.price) ₺"
        if let imageUrl = URL(string: "http://kasimadalan.pe.hu/urunler/resimler/\(model.imageUrl)") {
            productImage.kf.setImage(with: imageUrl)
        }
    }
    
    @IBAction func productDetailButton(_ sender: Any) {
        if let product = product {
            delegate?.didTapDetailButton(for: product)
        }
    }   
}

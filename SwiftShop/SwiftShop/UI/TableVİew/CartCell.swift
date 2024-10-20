//
//  CartCell.swift
//  SwiftShop
//
//  Created by Merve Çalışkan on 9.10.2024.
//

import UIKit
import Kingfisher

final class CartCell: UITableViewCell {
    
    @IBOutlet weak var cartImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)    
    }
    
     func configure(with item: GroupedCartItem) {
        
        productNameLabel.text = "\(item.ad)"
        productPriceLabel.text = "\(item.fiyat) ₺"
        productQuantityLabel.text = "Adet: \(item.siparisAdeti)"
        
        if let imageUrl = URL(string: "http://kasimadalan.pe.hu/urunler/resimler/\(item.resim)") {
            cartImageView.kf.setImage(
                with: imageUrl,
                placeholder: UIImage(systemName: "photo"),
                options: [
                    .transition(.fade(0.2)),
                    .cacheOriginalImage
                ],
                completionHandler: { result in
                    switch result {
                    case .success(let value):
                        print("Resim yüklendi: \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        print("Resim yüklenemedi: \(error.localizedDescription)")
                    }
                }
            )
        }
    }
}

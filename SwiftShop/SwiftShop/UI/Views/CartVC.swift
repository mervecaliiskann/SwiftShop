//
//  CartVC.swift
//  SwiftShop
//
//  Created by Merve Çalışkan on 9.10.2024.
//

import UIKit
import Kingfisher

final class CartVC: UIViewController {
    
    @IBOutlet private weak var cartTableView: UITableView!
    
    private let cartViewModel = CartVM(serviceManager: URLSessionServiceManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.tintColor = .systemGreen
        tableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCartItems()
    }
    
    private func tableView() {
        cartTableView.dataSource = self
        cartTableView.delegate = self
    }
    private func fetchCartItems() {
        cartViewModel.fetchCartItems { success in
            if success {
                DispatchQueue.main.async {
                    self.cartTableView.reloadData()
                }
            }
        }
    }
}

extension CartVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartViewModel.cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cartCells", for: indexPath) as? CartCell else {
            return UITableViewCell()
        }
        let cartItem = cartViewModel.cartItems[indexPath.row]
        cell.configure(with: cartItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let product = cartViewModel.cartItems[indexPath.row]
            cartViewModel.removeProductFromCart(productId: product.sepetIds.first ?? 0) { success in
                if success {
                    DispatchQueue.main.async {
                        self.cartViewModel.cartItems.remove(at: indexPath.row)
                        self.cartTableView.deleteRows(at: [indexPath], with: .automatic)
                        self.fetchCartItems()
                    }
                }
            }
        }
    }
}



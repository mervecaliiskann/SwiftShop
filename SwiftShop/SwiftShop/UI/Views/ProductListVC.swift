//
//  ProductListVC.swift
//  SwiftShop
//
//  Created by Merve Çalışkan on 7.10.2024.
//

import UIKit
import Kingfisher
import FirebaseAuth

final class ProductListVC: UIViewController {
    
    @IBOutlet private weak var productsTableView: UITableView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let viewModel = ProductVM(serviceManager: URLSessionServiceManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.tintColor = .systemGreen

        setupTableView()
        setupSearchController()
        
        viewModel.fetchProducts {
            DispatchQueue.main.async {
                self.productsTableView.reloadData()
            }
        }
    }
    
    private func setupTableView() {
        productsTableView.delegate = self
        productsTableView.dataSource = self
    }
    
    private func setupSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Ürün arayın"
        definesPresentationContext = true
    }
}

extension ProductListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.isFiltering = !searchText.isEmpty
        viewModel.filterProducts(by: searchText)
        productsTableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.isFiltering = false
        productsTableView.reloadData()
        searchBar.resignFirstResponder()
    }
}
extension ProductListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let headerView = UIView()
           headerView.backgroundColor = .white
           let label = UILabel()
           label.text = viewModel.currentSections[section].title
           label.textColor = .black
           label.font = UIFont.boldSystemFont(ofSize: 25)
           label.translatesAutoresizingMaskIntoConstraints = false
           headerView.addSubview(label)
           NSLayoutConstraint.activate([
               label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
               label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16)
           ])
           return headerView
       }

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.currentSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currentSections[section].products.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sections[section].title
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsCell", for: indexPath) as? ProductsCell else {
            return UITableViewCell()
        }
        let section = viewModel.currentSections[indexPath.section]
        guard indexPath.row < section.products.count else {
            return UITableViewCell()
        }
        let product = section.products[indexPath.row]
        cell.prepareCell(with: product)
        cell.delegate = self
        
        return cell
    }
}

extension ProductListVC: ProductsCellDelegate {
    
    func didTapDetailButton(for product: Product) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "detail") as? ProductDetailVC {
            detailVC.product = product
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}


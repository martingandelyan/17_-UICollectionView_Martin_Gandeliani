//
//  ViewController.swift
//  17_ UICollectionView_Martin_Gandeliani
//
//  Created by Martin on 18.11.25.
//

import UIKit

struct Product {
    let productName: String
    let productPrice: Int
    var amount: Int
}

class ProductViewController: UIViewController {
        let productCollectionView: UICollectionView = {
        let configuration = UICollectionViewFlowLayout()
            configuration.scrollDirection = .vertical
            configuration.itemSize = CGSize(width: 170, height: 150)
            configuration.minimumLineSpacing = 100
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configuration)
        return collectionView
    }()
    
    var products: [Product] = [Product(productName: "iPhone 13 📱", productPrice: 130, amount: 0),
                               Product(productName: "iPhone 14 📱", productPrice: 140, amount: 0),
                               Product(productName: "iPhone 15 📱", productPrice: 150, amount: 0),
                               Product(productName: "iPhone 16 📱", productPrice: 160, amount: 0),
                               Product(productName: "iPhone 17 📱", productPrice: 170, amount: 0),
                               Product(productName: "iPhone 12 📱", productPrice: 110, amount: 0),
                               Product(productName: "iPhone 11 📱", productPrice: 100, amount: 0),
                               Product(productName: "iPhone X 📱", productPrice: 80, amount: 0),
                               Product(productName: "iPhone 8 📱", productPrice: 70, amount: 0),
                               Product(productName: "iPhone 7 📱", productPrice: 60, amount: 0)
    ]
    
    var productPriceSumLbl = UILabel()
    var viewDefaultBackgroundColor: UIColor?
    var defaultViewColor: UIColor {
        viewDefaultBackgroundColor ?? .lightGray
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = defaultViewColor
        setupDesign()
    }
    
    private func setupDesign() {
        view.addSubview(productCollectionView)
        productCollectionView.translatesAutoresizingMaskIntoConstraints = false
        productCollectionView.backgroundColor = .orange
        
        view.addSubview(productPriceSumLbl)
        productPriceSumLbl.text = "Total: 0.00 $"
        productPriceSumLbl.translatesAutoresizingMaskIntoConstraints = false
        productPriceSumLbl.font = .systemFont(ofSize: 20, weight: .bold)
        
        NSLayoutConstraint.activate([
            productCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            productCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            productCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            productCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            
            productPriceSumLbl.topAnchor.constraint(equalTo: productCollectionView.bottomAnchor, constant: 10),
            productPriceSumLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        productCollectionView.register(ProductCollectionCell.self, forCellWithReuseIdentifier: "ProductCollectionCell")
    }
    
    private func updateTotalPrice() {
        var total = 0
        
        for product in products {
            total += product.amount * product.productPrice
        }
        
        productPriceSumLbl.text = "Total: \(total) $"
    }
}


extension ProductViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionCell", for: indexPath) as! ProductCollectionCell
        
            let productsInfo = products[indexPath.row]
            productCell.configure(with: productsInfo, index: indexPath.row)
            productCell.delegate = self
            
            return productCell
            
        }
    }

extension ProductViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productsInfo = products[indexPath.row]
        print("\(productsInfo.productName) pressed ")
    }
}

extension ProductViewController: ProductCollectionDelegate {
    func addProduct(cell: ProductCollectionCell?) {
        guard let cell else { return }
        guard let indexPath = productCollectionView.indexPath(for: cell) else { return }
        
        var productAmountChange = products[indexPath.row]
        productAmountChange.amount += 1
        
        products[indexPath.row] = productAmountChange
        updateTotalPrice()
        productCollectionView.reloadData()
    }
    
    func removeProduct(cell: ProductCollectionCell?) {
        guard let cell else { return }
        guard let indexPath = productCollectionView.indexPath(for: cell) else { return }
        
        var productAmountChange = products[indexPath.row]
        
        guard productAmountChange.amount > 0 else {
            let alertController = UIAlertController(title: "პროდუქტი ვერ გამოაკლდა", message: "0 - ზე ნაკლები ვერ იქნება", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "დახურვა", style: .cancel))
            self.present(alertController, animated: true)
            return
        }
        
        productAmountChange.amount -= 1
        
        products[indexPath.row] = productAmountChange
        updateTotalPrice()
        productCollectionView.reloadData()
    }
    
    func removeFromList(cell: ProductCollectionCell?) {
        guard let cell else { return }
        guard let indexPath = productCollectionView.indexPath(for: cell) else { return }
        
        products.remove(at: indexPath.row)
        updateTotalPrice()
        productCollectionView.deleteItems(at: [indexPath])
    }
}

import SwiftUI
#Preview {
    ProductViewController()
}

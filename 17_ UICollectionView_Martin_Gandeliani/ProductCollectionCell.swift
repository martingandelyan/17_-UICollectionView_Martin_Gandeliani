//
//  ProductCollectionCell.swift
//  17_ UICollectionView_Martin_Gandeliani
//
//  Created by Martin on 18.11.25.
//

import UIKit

protocol ProductCollectionDelegate {
    func addProduct(cell: ProductCollectionCell?)
    func removeProduct(cell: ProductCollectionCell?)
    func removeFromList(cell: ProductCollectionCell?)
}

class ProductCollectionCell: UICollectionViewCell {
    private let productNameLbl = UILabel()
    private let productCountLbl = UILabel()
    private let productPriceLbl = UILabel()
    private let addProductBtn = UIButton()
    private let removeProductBtn = UIButton()
    private let removeFromListBtn = UIButton()
    
    var delegate: ProductCollectionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButtons() {
        productNameLbl.backgroundColor = .cyan
        productNameLbl.textAlignment = .center
        productNameLbl.numberOfLines = 0
        
        productPriceLbl.backgroundColor = .green
        productPriceLbl.textAlignment = .center
        
        productCountLbl.text = "0"
        productCountLbl.textColor = .white
        
        addProductBtn.setTitle("+", for: .normal)
        addProductBtn.addAction(UIAction(handler: { [weak self] action in
            self?.delegate?.addProduct(cell: self)
        }), for: .touchUpInside)
        
        removeProductBtn.setTitle("-", for: .normal)
        removeProductBtn.addAction(UIAction(handler: { [weak self] action in
            self?.delegate?.removeProduct(cell: self)
        }), for: .touchUpInside)
        
        removeFromListBtn.setTitle("სიიდან ამოშლა", for: .normal)
        removeFromListBtn.backgroundColor = .red
        removeFromListBtn.addAction(UIAction(handler: { [weak self] action in
            self?.delegate?.removeFromList(cell: self)
        }), for: .touchUpInside)
    }
    
    func setupUI() {
        let labelsAndButtons = [productNameLbl, productPriceLbl, productCountLbl, addProductBtn, removeProductBtn, removeFromListBtn]
        labelsAndButtons.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            productNameLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productNameLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            productNameLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            
            productCountLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
            productCountLbl.topAnchor.constraint(equalTo: productNameLbl.bottomAnchor, constant: 10),
            
            productPriceLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productPriceLbl.topAnchor.constraint(equalTo: productCountLbl.bottomAnchor, constant: 10),
            productPriceLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            addProductBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            addProductBtn.centerYAnchor.constraint(equalTo: productCountLbl.centerYAnchor),
            
            removeProductBtn.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            removeProductBtn.centerYAnchor.constraint(equalTo: productCountLbl.centerYAnchor),
            
            removeFromListBtn.topAnchor.constraint(equalTo: productCountLbl.bottomAnchor, constant: 35),
            removeFromListBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            removeFromListBtn.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func configure(with product: Product, index: Int) {
        productNameLbl.text = "\(index) - \(product.productName)"
        productPriceLbl.text = "\(product.productPrice) $"
        productCountLbl.text = "\(product.amount)"
    }
}



import SwiftUI
#Preview {
    ProductViewController()
}

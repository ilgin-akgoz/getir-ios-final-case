//
//  ProductCollectionViewCell.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 20.04.2024.
//

import UIKit

protocol ProductCollectionViewCellProtocol: AnyObject {
    func setImage(_ imageName: String)
    func setPriceLabel(_ text: String)
    func setNameLabel(_ text: String)
    func setAttributeLabel(_ text: String)
}

final class ProductCollectionViewCell: UICollectionViewCell {
    
    var cellPresenter: ProductCollectionViewCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    private let imageView = UIImageView()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "₺0,00"
        label.textColor = .primaryColor
        label.font = .openSansBold(size: 15)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Product Name"
        label.font = .openSansBold(size: 14)
        return label
    }()
    
    private let attributeLabel: UILabel = {
        let label = UILabel()
        label.text = "Attribute"
        label.font = .openSansBold(size: 13)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(priceLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        attributeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(attributeLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            attributeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            attributeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            attributeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            attributeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension ProductCollectionViewCell: ProductCollectionViewCellProtocol {
    func setImage(_ imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
    
    func setPriceLabel(_ text: String) {
        priceLabel.text = text
    }
    
    func setNameLabel(_ text: String) {
        nameLabel.text = text
    }
    
    func setAttributeLabel(_ text: String) {
        attributeLabel.text = text
    }
}

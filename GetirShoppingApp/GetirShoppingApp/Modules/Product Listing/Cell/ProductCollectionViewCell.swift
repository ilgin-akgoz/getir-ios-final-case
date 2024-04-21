//
//  ProductCollectionViewCell.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 20.04.2024.
//

import UIKit

protocol ProductCollectionViewCellProtocol: AnyObject {
    func setImage(_ image: UIImage?)
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
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.borderWidth = 1
        image.layer.cornerRadius = 16
        image.clipsToBounds = true
        image.layer.borderColor = UIColor.imageBorderColor.cgColor
        return image
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "₺0,00"
        label.textColor = .primaryColor
        label.font = .openSansBold(size: 14)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Product Name"
        label.font = .openSansBold(size: 12)
        return label
    }()
    
    private let attributeLabel: UILabel = {
        let label = UILabel()
        label.text = "Attribute"
        label.font = .openSansBold(size: 10)
        label.textColor = .gray
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        button.layer.cornerRadius = 5
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .primaryColor
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowRadius = 3
        button.layer.shadowPath = UIBezierPath(roundedRect: button.bounds, cornerRadius: button.layer.cornerRadius).cgPath
        return button
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
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(addButton)
        
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
            
            addButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: -6),
            addButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 6),
            addButton.widthAnchor.constraint(equalToConstant: 24),
            addButton.heightAnchor.constraint(equalToConstant: 24),
            
            priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
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
    func setImage(_ image: UIImage?) {
        imageView.image = image
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

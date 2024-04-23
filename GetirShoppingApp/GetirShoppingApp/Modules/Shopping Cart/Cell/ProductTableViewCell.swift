//
//  ProductTableViewCell.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 23.04.2024.
//

import UIKit

protocol ProductTableViewCellProtocol: AnyObject {
    func setImage(_ image: UIImage?)
    func setPriceLabel(_ text: String)
    func setNameLabel(_ text: String)
    func setAttributeLabel(_ text: String)
}

final class ProductTableViewCell: UITableViewCell {
    var cellPresenter: ProductTableViewCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    private let productImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "placeholder")
        image.layer.borderWidth = 1
        image.layer.cornerRadius = 16
        image.clipsToBounds = true
        image.layer.borderColor = UIColor.imageBorderColor.cgColor
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Product Name"
        label.textColor = .textDarkColor
        label.font = .openSansSemiBold(size: 12)
        return label
    }()
    
    private let attributeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Attribute"
        label.textColor = .textSecondaryColor
        label.font = .openSansSemiBold(size: 12)
        label.textColor = .gray
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "₺0,00"
        label.textColor = .primaryColor
        label.font = .openSansBold(size: 14)
        return label
    }()
    
    private let stepperButton: StepperButton = {
        let button = StepperButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 6
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
        
        stepperButton.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        stepperButton.subtractButton.addTarget(self, action: #selector(subtractButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(productImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(attributeLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(stepperButton)
    }

    @objc private func addButtonTapped() {
        cellPresenter.tappedAddButton()
    }
    
    @objc private func subtractButtonTapped() {
        cellPresenter.tappedSubtractButton()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productImageView.widthAnchor.constraint(equalToConstant: 78),
            productImageView.heightAnchor.constraint(equalToConstant: 78),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: stepperButton.leadingAnchor),
            
            attributeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            attributeLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            attributeLabel.trailingAnchor.constraint(equalTo: stepperButton.leadingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: attributeLabel.bottomAnchor, constant: 2),
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: stepperButton.leadingAnchor),
            
            stepperButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stepperButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stepperButton.widthAnchor.constraint(equalToConstant: 102),
            stepperButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}

extension ProductTableViewCell: ProductTableViewCellProtocol {
    func setImage(_ image: UIImage?) {
        productImageView.image = image
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

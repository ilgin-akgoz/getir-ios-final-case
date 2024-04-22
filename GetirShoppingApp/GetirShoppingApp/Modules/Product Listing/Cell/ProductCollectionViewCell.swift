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
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "placeholder")
        image.layer.borderWidth = 1
        image.layer.cornerRadius = 16
        image.clipsToBounds = true
        image.layer.borderColor = UIColor.imageBorderColor.cgColor
        return image
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "₺0,00"
        label.textColor = .primaryColor
        label.font = .openSansBold(size: 14)
        return label
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        
        stepperButton.subtractButton.isHidden = true
        stepperButton.countLabel.isHidden = true
        
        stepperButton.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        stepperButton.subtractButton.addTarget(self, action: #selector(subtractButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(stepperButton)
        contentView.addSubview(priceLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(attributeLabel)
    }

    @objc private func addButtonTapped() {
        cellPresenter.tappedAddButton()
        UIView.animate(withDuration: 0.3) {
            self.imageView.layer.borderColor = UIColor.primaryColor.cgColor
        }
    }
    
    @objc private func subtractButtonTapped() {
        cellPresenter.tappedSubtractButton()
        if stepperButton.count == 0 {
            UIView.animate(withDuration: 0.3) {
                self.imageView.layer.borderColor = UIColor.imageBorderColor.cgColor
            }
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            stepperButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: -6),
            stepperButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 6),
            stepperButton.widthAnchor.constraint(equalToConstant: 96),
            stepperButton.heightAnchor.constraint(equalToConstant: 32),
            
            priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 2),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 2),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            attributeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            attributeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            attributeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            attributeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        stepperButton.rotate()
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

//
//  ProductDetailViewController.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 16.04.2024.
//

import UIKit

protocol ProductDetailViewControllerProtocol: AnyObject {
    func setTitle(_ title: String)
    func setBackgroundColor(_ color: UIColor)
    func setupNavigationBarButtonItem()
    func setupTabBar()
    func setupStackView(image: UIImage, price: String, name: String, attribute: String)
}

final class ProductDetailViewController: UIViewController {
    var presenter: ProductDetailPresenterProtocol!
    var tabBarButton: UIButton!
    var stepperButton: StepperButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewDidLoad()
    }
}

extension ProductDetailViewController: ProductDetailViewControllerProtocol {
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setBackgroundColor(_ color: UIColor) {
        self.view.backgroundColor = color
    }
    
    func setupStackView(image: UIImage, price: String, name: String, attribute: String) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        
        let priceLabel = UILabel()
        priceLabel.text = price
        priceLabel.textColor = .primaryColor
        priceLabel.font = .openSansBold(size: 20)
        
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.textColor = .textDarkColor
        nameLabel.font = .openSansSemiBold(size: 16)
        
        let attributeLabel = UILabel()
        attributeLabel.text = attribute
        attributeLabel.textColor = .textSecondaryColor
        attributeLabel.font = .openSansBold(size: 12)
        
        let stackView = UIStackView(arrangedSubviews: [imageView, priceLabel, nameLabel, attributeLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .center
        
        let bottomBorder = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1))
        bottomBorder.backgroundColor = UIColor(red: 0.92, green: 0.96, blue: 0.93, alpha: 1.00)
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomBorder)
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            bottomBorder.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 12),
            bottomBorder.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBorder.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBorder.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setupNavigationBarButtonItem() {
        let leftButton = UIBarButtonItem(image: UIImage(named: "left_controls"), style: .plain, target: self, action: #selector(backToListButtonTapped))
        leftButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc private func backToListButtonTapped() {
        presenter.tappedBackToList()
    }
    
    func setupTabBar() {
        let tabBar: UITabBar = {
            let tabBar = UITabBar()
            tabBar.barTintColor = .white
            tabBar.translatesAutoresizingMaskIntoConstraints = false
            tabBar.layer.shadowColor = UIColor(red: 105/255, green: 116/255, blue: 136/255, alpha: 0.12).cgColor
            tabBar.layer.shadowOffset = CGSize(width: 0, height: -4)
            tabBar.layer.shadowRadius = 8
            tabBar.layer.shadowOpacity = 1
            return tabBar
        }()
        
        tabBarButton = {
            let button = UIButton()
            button.backgroundColor = .primaryColor
            button.titleLabel?.font = .openSansBold(size: 14)
            button.setTitle("Sepete Ekle", for: .normal)
            button.layer.cornerRadius = 10
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
            return button
        }()
        
        stepperButton = {
            let button = StepperButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.isHidden = true
            button.layer.cornerRadius = 8
            button.layer.masksToBounds = true
            button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 1)
            button.layer.shadowOpacity = 1
            button.layer.shadowRadius = 6
            return button
        }()

        view.addSubview(tabBar)
        tabBar.addSubview(tabBarButton)
        tabBar.addSubview(stepperButton)
        
        NSLayoutConstraint.activate([
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBar.heightAnchor.constraint(equalToConstant: 100),
            tabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            tabBarButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            tabBarButton.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor),
            tabBarButton.widthAnchor.constraint(equalToConstant: 343),
            tabBarButton.heightAnchor.constraint(equalToConstant: 50),
            
            stepperButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            stepperButton.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor),
            stepperButton.widthAnchor.constraint(equalToConstant: 146),
            stepperButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    @objc private func addToCartButtonTapped() {
        presenter.tappedAddToCart()
        tabBarButton.isHidden = true
        stepperButton.isHidden = false
    }
}

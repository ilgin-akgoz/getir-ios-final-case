//
//  ShoppingCartViewController.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 16.04.2024.
//

import UIKit

protocol ShoppingCartViewControllerProtocol: AnyObject {
    func setTitle(_ title: String)
    func setBackgroundColor(_ color: UIColor)
    func setupNavigationBarButtonItems()
    func setupTabBar()
}

final class ShoppingCartViewController: UIViewController {
    var presenter: ShoppingCartPresenterProtocol!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewDidLoad()
    }
}

extension ShoppingCartViewController: ShoppingCartViewControllerProtocol {
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setBackgroundColor(_ color: UIColor) {
        self.view.backgroundColor = color
    }
    
    func setupNavigationBarButtonItems() {
        let leftButton = UIBarButtonItem(image: UIImage(named: "left_controls"), style: .plain, target: self, action: #selector(backToListButtonTapped))
        leftButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = leftButton
        
        let rightButton = UIBarButtonItem(image: UIImage(named: "right_controls"), style: .plain, target: self, action: #selector(trashButtonTapped))
        rightButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = rightButton
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
        
        let tabBarButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = .primaryColor
            button.titleLabel?.font = .openSansBold(size: 14)
            button.setTitle("Siparişi Tamamla", for: .normal)
            button.layer.cornerRadius = 10
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(placeOrderButtonTapped), for: .touchUpInside)
            return button
        }()
        
        let amountLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "₺0,00"
            label.textAlignment = .center
            label.textColor = .primaryColor
            label.font = .openSansBold(size: 20)
            label.backgroundColor = .white
            return label
        }()
        
        view.addSubview(tabBar)
        tabBar.addSubview(tabBarButton)
        tabBar.addSubview(amountLabel)
        
        NSLayoutConstraint.activate([
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBar.heightAnchor.constraint(equalToConstant: 100),
            tabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            tabBarButton.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor, constant: 16),
            tabBarButton.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor),
            tabBarButton.widthAnchor.constraint(equalToConstant: 235),
            tabBarButton.heightAnchor.constraint(equalToConstant: 50),
            
            amountLabel.leadingAnchor.constraint(equalTo: tabBarButton.trailingAnchor, constant: 16),
            amountLabel.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor, constant: -16),
            amountLabel.widthAnchor.constraint(equalToConstant: 116),
            amountLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc private func backToListButtonTapped() {
        presenter.tappedBackToList()
    }
    
    @objc private func trashButtonTapped() {
        presenter.tappedTrash()
    }
    
    @objc private func placeOrderButtonTapped() {
        presenter.tappedPlaceOrder()
    }
}

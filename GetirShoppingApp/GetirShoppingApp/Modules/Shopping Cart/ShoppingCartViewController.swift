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
    func setupTableView()
    func setupTabBar()
    func reloadData()
}

final class ShoppingCartViewController: UIViewController {
    var tableView: UITableView!
    var presenter: ShoppingCartPresenterProtocol!
    private var amountLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewDidLoad()
        registerObservers()
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
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .backgroundColor
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
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
        
        amountLabel = {
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
        
        amountLabel.text = presenter.getTotalPrice()
    }
    
    @objc private func backToListButtonTapped() {
        presenter.tappedBackToList()
    }
    
    @objc private func trashButtonTapped() {
        presenter.tappedTrash()
    }
    
    @objc private func placeOrderButtonTapped() {
        let total = presenter.getTotalPrice()
        let alertController = UIAlertController(title: "Siparişiniz Onaylandı", message: "\(total) tutarındaki siparişiniz onaylandı.", preferredStyle: .alert)
        
        let goBackToListingAction = UIAlertAction(title: "Anasayfaya dön", style: .default) { _ in
            self.presenter.tappedPlaceOrder()
        }
        
        alertController.addAction(goBackToListingAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterObservers()
    }
    
    private func registerObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(totalPriceDidChange(_:)), name: .cartUpdatedNotification, object: nil)
    }
    
    private func unregisterObservers() {
        NotificationCenter.default.removeObserver(self, name: .cartUpdatedNotification, object: nil)
    }
    
    @objc private func totalPriceDidChange(_ notification: Notification) {
        let amount = presenter.getTotalPrice()
        amountLabel.text = amount
    }
}

extension ShoppingCartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        
        if let product = presenter.product(indexPath.row) {
            cell.cellPresenter = ProductTableViewCellPresenter(view: cell, product: product)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

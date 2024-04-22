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
        //TODO: set up tab bar
    }
    
    @objc private func backToListButtonTapped() {
        presenter.tappedBackToList()
    }
    
    @objc private func trashButtonTapped() {
        presenter.tappedTrash()
    }
}

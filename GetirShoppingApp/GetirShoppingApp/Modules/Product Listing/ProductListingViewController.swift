//
//  ProductListingViewController.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 16.04.2024.
//

import UIKit

protocol ProductListingViewControllerProtocol: AnyObject {
    func setTitle(_ title: String)
    func setBackgroundColor(_ color: UIColor)
    func setupNavigationBarButtonItem()
    func setupCollectionView()
    func reloadData()
}

final class ProductListingViewController: UIViewController {
    var collectionView: UICollectionView!
    var presenter: ProductListingPresenterProtocol!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewDidLoad()
    }
}

extension ProductListingViewController: ProductListingViewControllerProtocol {
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setBackgroundColor(_ color: UIColor) {
        self.view.backgroundColor = color
    }
    
    func setupNavigationBarButtonItem() {
        let cartButton = CartButton()
        cartButton.addTarget(self, action: #selector(shoppingCartButtonTapped), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem(customView: cartButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func shoppingCartButtonTapped() {
        presenter.tappedShoppingCart()
    }
    
    func setupCollectionView() {
        let collectionViewLayout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(0.25))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 8
                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
                section.decorationItems = [
                    NSCollectionLayoutDecorationItem.background(elementKind: SectionBackgroundView.reuseIdentifier)
                ]
                return section
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.25))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 8
                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
                section.decorationItems = [
                    NSCollectionLayoutDecorationItem.background(elementKind: SectionBackgroundView.reuseIdentifier)
                ]
                return section
            }
        }
        
        collectionViewLayout.register(SectionBackgroundView.self, forDecorationViewOfKind: SectionBackgroundView.reuseIdentifier)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .backgroundColor
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "ProductCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension ProductListingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            presenter.suggestedNumberOfItems()
        } else {
            presenter.numberOfItems()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.section == 0 {
            if let product = presenter.suggestedProduct(indexPath.row) {
                cell.cellPresenter = ProductCollectionViewCellPresenter(view: cell, product: product)
            }
        } else {
            if let product = presenter.product(indexPath.row) {
                cell.cellPresenter = ProductCollectionViewCellPresenter(view: cell, product: product)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if let product = presenter.suggestedProduct(indexPath.row) {
                presenter.didSelectItem(product)
            }
        } else {
            if let product = presenter.product(indexPath.row) {
                presenter.didSelectItem(product)
            }
        }
        
    }
}



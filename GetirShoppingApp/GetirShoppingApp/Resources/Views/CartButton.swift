//
//  CartButton.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 22.04.2024.
//

import UIKit

final class CartButton: UIButton {
    let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        return button
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "₺0,00"
        label.textAlignment = .center
        label.font = .openSansBold(size: 14)
        label.backgroundColor = UIColor(red: 0.95, green: 0.94, blue: 0.98, alpha: 1.00)
        label.textColor = .primaryColor
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        return label
    }()
    
    var amount: String = "" {
        didSet {
            amountLabel.text = amount
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        
        updateAmount()
        NotificationCenter.default.addObserver(self, selector: #selector(updateAmount),
                                               name: .cartUpdatedNotification, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonWidth = bounds.width
        let buttonHeight = bounds.height
        
        button.frame = CGRect(x: -buttonWidth * 2, y: 0, width: buttonWidth, height: buttonHeight)
        amountLabel.frame = CGRect(x: -buttonWidth, y: 0, width: buttonWidth * 2, height: buttonHeight)
        
    }
    
    @objc private func updateAmount() {
        amount = CartManager.shared.getTotalPrice()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupSubviews() {
        button.setImage(UIImage(named: "cart_icon"), for: .normal)
        addSubview(button)
        addSubview(amountLabel)
    }
}

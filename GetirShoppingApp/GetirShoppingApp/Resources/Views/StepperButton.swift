//
//  StepperButton.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 22.04.2024.
//

import UIKit

final class StepperButton: UIButton {
    let addButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    let subtractButton = UIButton()

    let countLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = .openSansBold(size: 12)
        label.backgroundColor = .primaryColor
        label.textColor = .white
        return label
    }()
    
    var count: Int = 0 {
        didSet {
            countLabel.text = "\(count)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonWidth = bounds.width / 3
        let buttonHeight = bounds.height
        
        addButton.frame = CGRect(x: buttonWidth * 2, y: 0, width: buttonWidth, height: buttonHeight)
        subtractButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight)
        countLabel.frame = CGRect(x: buttonWidth, y: 0, width: buttonWidth, height: buttonHeight)
    }
    
    private func setupSubviews() {
        addButton.setImage(UIImage(named: "add_icon"), for: .normal)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addSubview(addButton)
        
        subtractButton.setImage(UIImage(named: "trash_icon"), for: .normal)
        subtractButton.addTarget(self, action: #selector(subtractButtonTapped), for: .touchUpInside)
        addSubview(subtractButton)
        
        addSubview(countLabel)
    }
    
    @objc private func addButtonTapped() {
        count += 1
        
        if count > 1 {
            subtractButton.setImage(UIImage(named: "subtract_icon"), for: .normal)
        }
        
        subtractButton.isHidden = false
        countLabel.isHidden = false
    }
    
    @objc private func subtractButtonTapped() {
        if count > 2 {
            count -= 1
        } else if count == 2 {
            count -= 1
            subtractButton.setImage(UIImage(named: "trash_icon"), for: .normal)
        } else {
            count = 0
            subtractButton.isHidden = true
            countLabel.isHidden = true
        }
    }

    func rotate() {
        self.anchorPoint = CGPoint(x: 0.8, y: -0.5)
        self.transform = CGAffineTransform(rotationAngle: -90 * .pi / 180)
        self.subtractButton.transform = CGAffineTransform(rotationAngle: 90 * .pi / 180)
        self.countLabel.transform = CGAffineTransform(rotationAngle: 90 * .pi / 180)
    }
}

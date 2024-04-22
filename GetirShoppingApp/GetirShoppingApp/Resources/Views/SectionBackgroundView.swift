//
//  SectionBackgroundView.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 21.04.2024.
//

import UIKit

final class SectionBackgroundView: UICollectionReusableView {
    private var insetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(insetView)

        NSLayoutConstraint.activate([
            insetView.topAnchor.constraint(equalTo: topAnchor,  constant: 16),
            insetView.leadingAnchor.constraint(equalTo: leadingAnchor),
            insetView.bottomAnchor.constraint(equalTo: bottomAnchor),
            trailingAnchor.constraint(equalTo: insetView.trailingAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



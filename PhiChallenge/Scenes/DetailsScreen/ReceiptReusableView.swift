//
//  StatementDetailsView.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 13/11/20.
//

import UIKit

final class ReceiptReusableView: UIView {
    //MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blackHex
        label.textAlignment = .left
        label.font = UIFont(name: Fonts.arialBold, size: 15)
        label.numberOfLines = 1
        
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blackHex
        label.textAlignment = .left
        label.font = UIFont(name: Fonts.arialMT, size: 17)
        label.numberOfLines = 1
        
        return label
    }()
    
    //MARK: - Initialization
    
    init(title: String? = nil, text: String? = nil, font: String? = nil) {
        
        super.init(frame: .init())
        
        titleLabel.text = title
        textLabel.text = text
        textLabel.font = UIFont(name: font ?? Fonts.arialMT, size: 17)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

//MARK: - ViewConfiguration
extension ReceiptReusableView: ViewConfiguration {
    func setupConstraints() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 50)
            ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            textLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
    
    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(textLabel)
    }
}

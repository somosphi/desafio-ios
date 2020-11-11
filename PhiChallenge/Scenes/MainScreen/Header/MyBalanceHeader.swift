//
//  myBalanceHeaderView.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 10/11/20.
//

import UIKit

final class MyBalanceHeader: UIView {

    private let myBalanceLabel: UILabel = {
        let label = UILabel()
        label.text = "Seu Saldo"
        label.textColor = .blackHex
        label.textAlignment = .left
        label.font = UIFont(name: Fonts.arial, size: 16)
        
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: Fonts.arialBold, size: 26)
        label.text = "R$ 1345,00"
        label.textColor = .cyanHex
        label.isHidden = false
        
        return label
    }()
    
    private let eyeImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .cyanHex
        
        return imageView
    }()
    
    private let hideAmountView: UIImageView = {
        let imageView = UIImageView()
         imageView.backgroundColor = .cyanHex
         imageView.isHidden = true
         
         return imageView
    }()
    
    //MARK: -  Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
       setupViewConfiguration()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        backgroundColor = .lightGrayHex
        
    }
}

extension MyBalanceHeader: ViewConfiguration {
    func setupConstraints() {
//        translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            topAnchor.constraint(equalTo: topAnchor),
//            leadingAnchor.constraint(equalTo: leadingAnchor),
//            trailingAnchor.constraint(equalTo: trailingAnchor),
//            bottomAnchor.constraint(equalTo: bottomAnchor),
//            heightAnchor.constraint(equalToConstant: 100)
//        ])
        
    }
    
    func buildViewHierarchy() {
   
    }
    
    
    
}

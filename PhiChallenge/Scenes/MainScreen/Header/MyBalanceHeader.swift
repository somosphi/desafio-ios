//
//  myBalanceHeaderView.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 10/11/20.
//

import UIKit

final class MyBalanceHeader: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
//       setupViewConfiguration()
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

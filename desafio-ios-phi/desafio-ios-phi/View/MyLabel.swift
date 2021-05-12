//
//  MyLabel.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 12/05/21.
//

import UIKit

class MyLabel: UILabel {
    init(textColor: UIColor,
         font: UIFont,
         text: String = "",
         alignment: NSTextAlignment,
         backgroundColor: UIColor = .clear) {
       
        super.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = alignment
        self.backgroundColor = backgroundColor
        self.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  PHILabel.swift
//  desafio-phi
//
//  Created by Marcus Vinicius Vieira Badiale on 25/02/21.
//

import UIKit

open class PHILabel: UILabel {
    
    public convenience init(text: String? = nil,
                            textColor: UIColor = .appBlack,
                            fontStyle: UIFont.TextStyle = .headline,
                            font: UIFont = UIFont.systemFont(ofSize: 16, weight: .bold)) {
        self.init()
        
        if text != nil {
            self.text = text
        }
        self.textColor = textColor
        
        //Dynamic font
        let metrics = UIFontMetrics(forTextStyle: fontStyle)
        self.font = metrics.scaledFont(for: font)
        self.adjustsFontForContentSizeCategory = true
        self.adjustsFontSizeToFitWidth = true
    }
}

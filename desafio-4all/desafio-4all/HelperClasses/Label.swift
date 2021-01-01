//
//  Label.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 01/01/21.
//

import UIKit

class BaseLabel: UILabel {
    
    let fontSize25: CGFloat = 25
    let fontSize17: CGFloat = 17
    let fontSize14: CGFloat = 14
    let fontSize12: CGFloat = 12
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        textColor = .appBlack
        font = UIFont.systemFont(ofSize: fontSize17)
    }
    
    func setCurrencyText(amount: Double) {
        var resultAmount = amount
        var symbol = ""
        if amount < 0 {
            resultAmount = amount * -1
            symbol = "-"
        }
        
        let amountFormatString = String(format: "%.2f", resultAmount)
        text = "\(symbol) R$ \(amountFormatString)"
    }
}

// MARK: - Large

class LargeGreenLabel: BaseLabel {
    
    override func setup() {
        super.setup()
        textColor = .appGreen
        font = UIFont.systemFont(ofSize: fontSize25, weight: .semibold)
    }
}

// MARK: - Medium

class MediumSemiboldLabel: BaseLabel {
    
    override func setup() {
        super.setup()
        font = UIFont.systemFont(ofSize: fontSize17, weight: .semibold)
    }
}

class MediumBoldLabel: BaseLabel {
    
    override func setup() {
        super.setup()
        font = UIFont.systemFont(ofSize: fontSize17, weight: .bold)
    }
}

class MediumGrayLabel: BaseLabel {
    
    override func setup() {
        super.setup()
        textColor = .appGrey
        font = UIFont.systemFont(ofSize: fontSize17)
    }
}

// MARK: - Small

class SmallGreyLabel: BaseLabel {
    
    override func setup() {
        super.setup()
        textColor = .appGrey
        font = UIFont.systemFont(ofSize: fontSize14)
    }
}

// MARK: - Extra Small

class ExtraSmallWhiteLabel: BaseLabel {
    
    override func setup() {
        super.setup()
        textColor = .white
        font = UIFont.systemFont(ofSize: fontSize12)
    }
}

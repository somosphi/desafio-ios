//
//  HideButton.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 01/01/21.
//

import UIKit

class HideButton: UIButton {
    
    var buttonIsHidden: Bool = false {
        didSet{
            let imageName = buttonIsHidden ? "eye.fill" : "eye.slash.fill"
            setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        tintColor = .appGreen
        buttonIsHidden = UserDefaults.standard.bool(forKey:StringConstants.balanceIsHiddenUserDefaults)
    }
    
    func buttonTouched() {
        self.buttonIsHidden = buttonIsHidden ? false : true
        UserDefaults.standard.set(buttonIsHidden, forKey: StringConstants.balanceIsHiddenUserDefaults)
    }

}

//
//  CustomNavigationController.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 31/12/20.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.navigationBar.barTintColor = .white
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.tintColor = .black
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

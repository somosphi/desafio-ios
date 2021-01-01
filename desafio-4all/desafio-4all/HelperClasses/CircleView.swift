//
//  CircleView.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 01/01/21.
//

import UIKit

class CircleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.width/2
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

//
//  ActivityIndicator.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 10/11/20.
//

import UIKit

final class ActivityIndicator: UIActivityIndicatorView {
    
    private var loaderColor: UIColor?
    
    init(frame: CGRect, loaderColor: UIColor) {
        super.init(frame: UIScreen.main.bounds)
        
        self.loaderColor = loaderColor
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        
        setup()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.color = loaderColor
        self.backgroundColor = UIColor.lightGrayHex?.withAlphaComponent(0.5)
        style = .large
        
    }
}


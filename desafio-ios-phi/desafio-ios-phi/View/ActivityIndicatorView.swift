//
//  ActivityIndicatorView.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 12/05/21.
//

import UIKit

class ActivityIndicatorView: UIActivityIndicatorView {
    
    override init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)
        color = .black
        startAnimating()
        autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin,
            .flexibleTopMargin, .flexibleBottomMargin
        ]
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

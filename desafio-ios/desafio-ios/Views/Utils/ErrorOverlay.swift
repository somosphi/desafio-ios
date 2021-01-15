//
//  ErrorOverlay.swift
//  desafio-ios
//
//  Created by Gustavo Igor Gonçalves Travassos on 15/01/21.
//

import UIKit

public class ErrorOverlay {
    
    var overlayView: UIView!
    var errorImage: UIImageView!
    var errorLabel: UILabel!
    
    public class var shared: ErrorOverlay {
        struct Static {
            static let instance: ErrorOverlay = ErrorOverlay()
        }
        return Static.instance
    }
    
    init() {
        self.overlayView = UIView()
        self.errorImage = UIImageView()
        self.errorLabel = UILabel()
        
        setup()
    }
    
    private func setup() {
        overlayView.frame = UIScreen.main.nativeBounds
        overlayView.backgroundColor = .white
        overlayView.clipsToBounds = true
        overlayView.layer.zPosition = 1
        
        errorImage.tintColor = .phiGreen
        errorImage.frame = CGRect(x: 0, y: 0, width: 80, height: 70)
        errorImage.center = CGPoint(x: overlayView.bounds.width / 2,
                                    y: overlayView.bounds.height / 3)
        
        errorLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorLabel.textColor = .phiBlack
        errorLabel.frame = CGRect(x: 0, y: 0, width: errorImage.bounds.width*2, height: errorImage.bounds.height*2)
        errorLabel.center = CGPoint(x: overlayView.bounds.width / 2,
                                    y: overlayView.bounds.height / 3 + errorImage.bounds.width/2 + 24)
        
        overlayView.addSubviews([errorImage, errorLabel], constraints: true)
    }
    
    public func showOverlay(view: UIView, errorImage: UIImage, message: String) {
        self.errorImage.image = errorImage
        self.errorLabel.text = message
        
        overlayView.center = view.center
        view.addSubview(overlayView)
    }
}


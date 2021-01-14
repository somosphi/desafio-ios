//
//  LoadingOverlay.swift
//  desafio-ios
//
//  Created by Gustavo Igor Gonçalves Travassos on 14/01/21.
//

import UIKit

public class LoadingOverlay {
    
    var overlayView: UIView!
    var activityIndicator: UIActivityIndicatorView!
    
    public class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }
    
    init() {
        self.overlayView = UIView()
        self.activityIndicator = UIActivityIndicatorView()
        
        setup()
    }
    
    private func setup() {
        overlayView.frame = UIScreen.main.nativeBounds
        overlayView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        overlayView.clipsToBounds = true
        overlayView.layer.zPosition = 1
        
        activityIndicator.color = .phiGreen
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2,
                                           y: overlayView.bounds.height / 2)
        activityIndicator.style = .large
        overlayView.addSubview(activityIndicator)
    }
    
    public func showOverlay(view: UIView) {
        overlayView.center = view.center
        view.addSubview(overlayView)
        activityIndicator.startAnimating()
    }
    
    public func hideOverlayView() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.overlayView.removeFromSuperview()
        }
    }
}

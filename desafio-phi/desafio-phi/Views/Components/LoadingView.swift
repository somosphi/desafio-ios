//
//  LoadingView.swift
//  desafio-phi
//
//  Created by Marcus Vinicius Vieira Badiale on 01/03/21.
//
import UIKit

public class LoadingView {
    
    var overlayView: UIView!
    var activityIndicator: UIActivityIndicatorView!
    
    static let shared = LoadingView()
    
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
        
        activityIndicator.color = .appGreen
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2,
                                           y: overlayView.bounds.height / 2)
        activityIndicator.style = .medium
        overlayView.addSubview(activityIndicator)
    }
    
    public func showLoadingIndicator(view: UIView) {
        overlayView.center = view.center
        view.addSubview(overlayView)
        activityIndicator.startAnimating()
    }
    
    public func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.overlayView.removeFromSuperview()
        }
    }
}

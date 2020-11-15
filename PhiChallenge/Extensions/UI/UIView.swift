//
//  UIView.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 11/11/20.
//

import UIKit

public extension UIView {
    @discardableResult
    func addTapGesture(with target: Any, action: Selector) -> UITapGestureRecognizer {
        let singleTap = UITapGestureRecognizer(
            target: target,
            action: action
        )
        
        singleTap.numberOfTapsRequired = 1
        self.addGestureRecognizer(singleTap)
        return singleTap
    
    }
        
    func scale(by scale: CGFloat) {
            self.contentScaleFactor = scale
            for subview in self.subviews {
                subview.scale(by: scale)
            }
        }

        func getImage(scale: CGFloat? = nil) -> UIImage {
            let newScale = scale ?? UIScreen.main.scale
            self.scale(by: newScale)

            let format = UIGraphicsImageRendererFormat()
            format.scale = newScale

            let renderer = UIGraphicsImageRenderer(size: self.bounds.size, format: format)

            let image = renderer.image { rendererContext in
                self.layer.render(in: rendererContext.cgContext)
            }

            return image
        }
   
}

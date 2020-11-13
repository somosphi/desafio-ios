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
   
}

//
//  StackView.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes Barbosa on 11/05/21.
//

import UIKit

extension UIView {
  
     func renderViewToUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        let image = renderer.image { _ in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
       return image
    }
}

//
//  UIStackViewBuilder.swift
//  DesafioIOS
//
//

import Foundation
import UIKit


class UIStackViewBuilder{
    let stackView = UIStackView()
    
    init(axis : NSLayoutConstraint.Axis){
        stackView.axis = axis
    }
    
    func withSpacing(_ spacing : CGFloat) -> Self{
        stackView.spacing = spacing
        return self
    }
    
    func withAligment(_ aligment : UIStackView.Alignment) -> Self{
        stackView.alignment = aligment
        return self
    }
    
    func withDistribution(_ distribution : UIStackView.Distribution) -> Self{
        stackView.distribution = distribution
        return self
    }
    
    
    func build() -> UIStackView{
        return stackView
    }
}

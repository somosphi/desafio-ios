//
//  UIExtensions.swift
//  DesafioIOS
//
//

import Foundation
import UIKit

extension UILabel{
    
    static func createDynamicFontLabel(fontStyle : UIFont.TextStyle, defaultText : String = "") -> UILabel{
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: fontStyle)
        label.adjustsFontForContentSizeCategory = true
        label.text = defaultText
        label.minimumScaleFactor = 0.3
        label.adjustsFontSizeToFitWidth = true
        return label
    }
}
protocol CellIdentifiable{
    static var identifier : String {get}
}

//https://www.hackingwithswift.com/example-code/media/how-to-render-a-uiview-to-a-uiimage
extension UIView{
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        let image = renderer.image { ctx in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
        return image
    }
}

extension UIView{
    
    func constraintsForAnchoringTo(view : UIView,
                                   top : CGFloat = 0,
                                   leading : CGFloat = 0,
                                   bottom : CGFloat = 0,
                                   trailing : CGFloat = 0) -> [NSLayoutConstraint] {
        
        return [
            topAnchor.constraint(equalTo: view.topAnchor, constant: top),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -1*bottom),
            trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -1*trailing),
        ]
    }
    
    func constraintsForAnchoringTo(view : UIView,
                                   padding : CGFloat) -> [NSLayoutConstraint] {
        
        return constraintsForAnchoringTo(view: view,
                                         top: padding,
                                         leading: padding,
                                         bottom: padding,
                                         trailing: padding)
    }
    
    func constraintsForAnchoringToSafeArea(view: UIView,
                                   top : CGFloat = 0,
                                   leading : CGFloat = 0,
                                   bottom : CGFloat = 0,
                                   trailing : CGFloat = 0) -> [NSLayoutConstraint]{
        return [
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: top),
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leading),
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -1*bottom),
            trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor , constant: -1*trailing),
        ]
    }
    
    func constraintsForAnchoringToSafeArea(view: UIView,
                                           padding : CGFloat) -> [NSLayoutConstraint]{
        return constraintsForAnchoringToSafeArea(view: view,
                                                 top: padding,
                                                 leading: padding,
                                                 bottom: padding,
                                                 trailing: padding)
    }
    
    func constraintsForCenterIn(view: UIView) -> [NSLayoutConstraint]{
        return [
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
    }

}

extension UIStackView{
    
    func addArrangedSubviewsInOrder(_ views : UIView...){
        views.forEach{
            self.addArrangedSubview($0)
        }
    }
    
}

extension CGRect{
    
    var centerX : CGFloat{
        return self.origin.x + self.width/2
    }
    
    var centerY : CGFloat{
        return self.origin.y + self.height/2
    }
    
    var center : CGPoint{
        return CGPoint(x: centerX, y: centerY)
    }
    
}

extension Array where Element : NSLayoutConstraint{
    func activate(){
        NSLayoutConstraint.activate(self)
    }
}

extension NSLayoutConstraint{
    func activate(){
        self.isActive = true
    }
    
    func setLessPriorityThan(otherConstraint : NSLayoutConstraint){
        self.priority = UILayoutPriority(otherConstraint.priority.rawValue - 10)
    }
}



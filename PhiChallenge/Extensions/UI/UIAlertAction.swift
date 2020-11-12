//
//  UIAlertAction.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 11/11/20.
//

import UIKit

extension UIAlertAction {
    var titleTextColor: UIColor? {
        get {
            return self.value(forKey: "titleTextColor") as? UIColor
        } set {
            self.setValue(newValue, forKey: "titleTextColor")
        }
    }
}

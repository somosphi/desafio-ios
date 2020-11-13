//
//  UIViewController.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 11/11/20.
//

import UIKit

extension UIViewController {
    func showAlert(title: String = "Ops...", message: String, alertAction: UIAlertAction) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            //let alertAction = UIAlertAction(title: "Try Again", style: .default, handler: nil)
            
            alertAction.titleTextColor = .cyanHex
            
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

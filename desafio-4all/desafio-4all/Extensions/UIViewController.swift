//
//  UIViewController.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 03/01/21.
//

import UIKit

extension UIViewController {
    
    func present(message: String) {
        let alert = UIAlertController(title: "4all Challenge", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func presentShareActivity(with image: UIImage) {
        createActivityViewController(items: [image])
    }
    
    func presentShareActivity(with url: URL) {
        createActivityViewController(items: [url])
    }
    
    private func createActivityViewController(items: [Any]) {
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.maxY, width: 0, height: 0)
        
        DispatchQueue.main.async {
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
}

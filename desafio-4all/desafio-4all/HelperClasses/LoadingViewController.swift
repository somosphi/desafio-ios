//
//  LoadingViewController.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 01/01/21.
//

import UIKit

class LoadingViewController: UIViewController  {
    var loadingAlert: UIAlertController?
}

extension LoadingViewController {
    
    func showLoadingPopup(){
        loadingAlert = UIAlertController(title: "", message: nil, preferredStyle: .alert)
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .appGreen
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        
        guard let alert = loadingAlert else { return }
        
        alert.view.addSubview(activityIndicator)
        alert.view.heightAnchor.constraint(equalToConstant: 80).isActive = true
        alert.view.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor, constant: 0).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: alert.view.centerYAnchor, constant: (activityIndicator.frame.height/2)).isActive = true
        
        DispatchQueue.main.async {
            self.present(alert, animated: false, completion: nil)
        }
    }
    
    func hideLoadingPopup(){
        if let alert = loadingAlert {
            DispatchQueue.main.async {
                alert.dismiss(animated: false, completion: nil)
            }
        }
    }
}

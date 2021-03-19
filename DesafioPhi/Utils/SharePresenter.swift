//
//  SharePresenter.swift
//  DesafioPhi
//
//  Created by Lucas Siqueira on 16/03/21.
//

import Foundation
import UIKit

/**
 Classe utilizada para exibir a aba de compartilhamento na view controller
 - note: A classe precisa seguir o protocolo 'SharePresenterProtocol'
*/
class SharePresenter: SharePresenterProtocol {
    
    // MARK: Present Share
    
    func presentShare(on viewController: UIViewController, completion: @escaping () -> Void) {
        let bounds = UIScreen.main.bounds
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        if let view = viewController.navigationController?.view {
            view.drawHierarchy(in: bounds, afterScreenUpdates: false)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let activityViewController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = viewController.view
        viewController.present(activityViewController, animated: true, completion: completion)
    }
    
}

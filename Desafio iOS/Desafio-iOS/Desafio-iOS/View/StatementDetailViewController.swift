//
//  StatementDetailViewController.swift
//  Desafio-iOS
//
//  Created by Alex Freitas on 24/05/21.
//

import UIKit

class StatementDetailViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var transferTo: UILabel!
    // banco
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var authenticationLabel: UILabel!

    let service = QueryService()
    var statementInfo: StatementInfo?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let transferId = statementInfo?.id {
            getDetail(id: transferId)
        }
    }

    func getDetail(id: String) {
        service.getDetail(transfer: id) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let statementDetail):
                DispatchQueue.main.async {
                    self.descriptionLabel.text = statementDetail.description
                    self.amountLabel.text = String(statementDetail.amount)
                    self.createdAtLabel.text = statementDetail.createdAt
                    self.authenticationLabel.text = statementDetail.authentication
                    self.transferTo.text = statementDetail.to
                }
            }
        }
    }
}

//extension UIView {
//
//    // Using a function since `var image` might conflict with an existing variable
//    // (like on `UIImageView`)
//    func asImage() -> UIImage {
//        let renderer = UIGraphicsImageRenderer(bounds: bounds)
//        return renderer.image { rendererContext in
//            layer.render(in: rendererContext.cgContext)
//        }
//    }
//}

/*
 let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
 let image = renderer.image { ctx in
     view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
 }
 */

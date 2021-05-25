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
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var authenticationLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!

    @IBAction func shareButtonPressed(_ sender: Any) {
        shareButton.isHidden = true
        let screenshot = self.view.takeScreenshot()
        receiptScreenshot = screenshot
        shareButton.isHidden = false
        performSegue(withIdentifier: "ShareReceipt", sender: nil)
    }

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShareReceipt" {
            guard let viewController = segue.destination as? ReceiptViewController else {
                print(Error.self)
                return
            }
        }
    }
}

extension UIView {
    func takeScreenshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return image
        } else {
            return UIImage()
        }
    }
}

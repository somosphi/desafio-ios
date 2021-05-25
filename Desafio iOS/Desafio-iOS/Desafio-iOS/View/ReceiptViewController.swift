//
//  ReceiptViewController.swift
//  Desafio-iOS
//
//  Created by Alex Freitas on 24/05/21.
//

import UIKit

var receiptScreenshot: UIImage = UIImage()

class ReceiptViewController: UIViewController {

    @IBOutlet weak var receiptImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        receiptImage.image = receiptScreenshot
        presentShareSheet(image: receiptScreenshot)
    }

    private func presentShareSheet(image: UIImage) {
        let shareSheet = UIActivityViewController(activityItems: [image], applicationActivities: nil)
//        shareSheet.popoverPresentationController?.sourceView = self.view
//        shareSheet.excludedActivityTypes = [.assignToContact]
//        shareSheet.isModalInPresentation = true
        present(shareSheet, animated: true, completion: nil)
    }
}

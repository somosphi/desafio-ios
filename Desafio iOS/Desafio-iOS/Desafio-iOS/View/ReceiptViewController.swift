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

    }
}

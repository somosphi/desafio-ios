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
        shareButton.isHidden = false
        presentShareSheet(image: screenshot)
    }

    let service = QueryService()
    var statementInfo: StatementInfo?

//    private var viewModel: StatementDetailViewModel = StatementDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

//        viewModel.bindViewModelToController = bind

        if let transferId = statementInfo?.id {
            getDetail(id: transferId)
        }
    }

//    func bind() {
//        setupDetailView()
//    }

//    func setupDetailView() {
//        DispatchQueue.main.async { [self] in
//            descriptionLabel.text = viewModel.statementDetail.description
//            amountLabel.text = String(viewModel.statementDetail.amount)
//            createdAtLabel.text = viewModel.statementDetail.createdAt
//            authenticationLabel.text = viewModel.statementDetail.authentication
//            transferTo.text = viewModel.statementDetail.to
//        }
//    }

    func getDetail(id: String) {
        service.getDetail(transfer: id) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let statementDetail):
                let amountValue = FormatterHelper.brCurrency(value: statementDetail.amount)
                let transferDate = FormatterHelper.detailedDate(date: statementDetail.createdAt)

                DispatchQueue.main.async {
                    self.descriptionLabel.text = statementDetail.description
                    self.amountLabel.text = amountValue
                    self.createdAtLabel.text = transferDate
                    self.authenticationLabel.text = statementDetail.authentication
                    self.transferTo.text = statementDetail.to
                }
            }
        }
    }

    private func presentShareSheet(image: UIImage) {
        let shareSheet = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(shareSheet, animated: true, completion: nil)
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

//
//  VoucherViewController.swift
//  Desafio_Somosphi
//
//  Created by Suh on 03/08/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var dateHourLabel: UILabel!
    @IBOutlet weak var authenticationLabel: UILabel!
    @IBOutlet weak var descriptionTargetLabel: UILabel!

    weak var coordinator: DetailCoordinator?
    var model: DetailModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        model?.service = DetailService()
        model?.loadDetail()

    }

    @IBAction func share(_ sender: UIButton) {

    }

}

extension DetailViewController: DetailModelDelegate {
    func didUpShowDetail() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.descriptionLabel.text = self.model?.statement?.description ?? ""
            self.targetLabel.text = self.model?.statement?.target
            self.bankLabel.text = self.model?.statement?.bankName
            self.authenticationLabel.text = self.model?.statement?.authentication
            self.descriptionTargetLabel.text = self.model?.statement?.typeTarget
            self.valueLabel.text = Formatter.formatCurrency(value: self.model?.statement?.amount ?? 0)
            self.dateHourLabel.text = Formatter.formatDate(
                string: self.model?.statement?.createdAt ?? "", from: .long, to: .long)

            print("chegueiiii")
        }
    }

}

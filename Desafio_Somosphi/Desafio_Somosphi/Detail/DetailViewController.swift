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

    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = "Transferência realizada"
        valueLabel.text = "R$ 1234,00"
        targetLabel.text = "David Bond"
        bankLabel.text = "Banco Phi"
        dateHourLabel.text = "20/10/2022 - 12:12:00"
        authenticationLabel.text = "15BA0BB3-EFDB-44E9-99BA-3D0F8725C0E3"
        descriptionTargetLabel.text = "Minha Conta"
    }

    @IBAction func share(_ sender: UIButton) {

    }

}

//
//  ViewController.swift
//  Desafio-iOS
//
//  Created by Alex Freitas on 28/04/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var showHideButton: UIButton!
    @IBOutlet weak var testImage: UIImageView!

    var amountValue: Double = 0.0

    override func viewDidLoad() {

//        if let myImage = UIImage(named: "view-hide") {
//            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
//            showHideButton.setImage(tintableImage, for: .normal)
//            // ver como mudar a cor da imagem de fundo do botao
//            showHideButton.tintColor = UIColor.init(named: "phiGreen")
//        }

        testImage.tintColor = UIColor.init(named: "phiGreen")

        let service = QueryService()

        service.getAmount { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let amount):
                self.amountValue = amount
            }
        }

        if UserDefaults.standard.bool(forKey: "HideAmount") {
            showHideButton.setImage(UIImage(named: "view-show"), for: .normal)
            self.amountLabel.text = "💸💸💸"
        } else {
            showHideButton.setImage(UIImage(named: "view-hide"), for: .normal)
            self.amountLabel.text = String(format: "%.2f", amountValue)
        }
    }

    @IBAction func showHideButtonPressed(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "HideAmount") {
            showHideButton.setImage(UIImage(named: "view-hide"), for: .normal)
            UserDefaults.standard.setValue(false, forKey: "HideAmount")
            DispatchQueue.main.async {
                self.amountLabel.text = String(format: "%.2f", self.amountValue)
            }
        } else {
            showHideButton.setImage(UIImage(named: "view-show"), for: .normal)
            UserDefaults.standard.setValue(true, forKey: "HideAmount")
            DispatchQueue.main.async {
                self.amountLabel.text = "💸💸💸"
            }
        }
    }

    @IBAction func apiTest(_ sender: Any) {
        let service = QueryService()

        service.getAmount { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let amount):
                DispatchQueue.main.async {
                    self.amountLabel.text = String(amount)
                }
            }
        }
    }
}

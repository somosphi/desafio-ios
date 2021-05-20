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
    @IBOutlet weak var amountActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!

    var amountValue: Double = 0.0
    var favourites: [Int] = []

    override func viewDidLoad() {

        // MARK: transformar numa função para atualizar quando recebe info da API
        if let myImage = UIImage(named: "phiHide") {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            showHideButton.setImage(tintableImage, for: .normal)
            showHideButton.tintColor = UIColor.init(named: "phiGreen")
        }

        self.amountLabel.isHidden = true
        self.amountActivityIndicator.startAnimating()
        self.amountActivityIndicator.isHidden = false

        tableView.delegate = self
        tableView.dataSource = self

        let service = QueryService()

        service.getAmount { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let amount):
                DispatchQueue.main.async {
                    self.amountValue = amount
                    self.amountActivityIndicator.isHidden = true
                    self.amountLabel.isHidden = false
                }
                hideAmount()
            }
        }

        service.getStatement { result in
            print(result)
            switch result {
            case .failure(let error):
                print(error)
            case .success(let statement):
                print(statement)
            }
        }

        func hideAmount() {
            if UserDefaults.standard.bool(forKey: "HideAmount") {
                DispatchQueue.main.async {
                    self.showHideButton.setImage(UIImage(named: "phiShow"), for: .normal)
                    self.amountLabel.text = "💸💸💸"
                }
            } else {
                DispatchQueue.main.async {
                    self.showHideButton.setImage(UIImage(named: "phiHide"), for: .normal)
                    self.amountLabel.text = String(format: "%.2f", self.amountValue)
                }
            }
        }

    }

    @IBAction func showHideButtonPressed(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "HideAmount") {
            showHideButton.setImage(UIImage(named: "phiHide"), for: .normal)
            UserDefaults.standard.setValue(false, forKey: "HideAmount")
            DispatchQueue.main.async {
                self.amountLabel.text = String(format: "%.2f", self.amountValue)
            }
        } else {
            showHideButton.setImage(UIImage(named: "phiShow"), for: .normal)
            UserDefaults.standard.setValue(true, forKey: "HideAmount")
            DispatchQueue.main.async {
                self.amountLabel.text = "💸💸💸"
            }
        }
    }
}

extension ViewController: UITableViewDelegate {

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatementItem", for: indexPath)
        return cell
    }
}

//
//  ViewController.swift
//  Desafio-iOS
//
//  Created by Alex Freitas on 28/04/21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Amount outlets
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var showHideButton: UIButton!
    @IBOutlet weak var amountActivityIndicator: UIActivityIndicatorView!
    var amountValue: Double?

    @IBOutlet weak var tableView: UITableView!

    var statementList: [StatementInfo] = []
    var statementInfo: StatementInfo?

    override func viewDidLoad() {

        setupAmountView()

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
                    self.setupAmountView()
                }
            }
        }

        service.getStatement { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let statement):
                DispatchQueue.main.async {
                    self.statementList = statement
                    self.tableView.reloadData()
                }
            }
        }
    }

    func setupAmountView() {
        let shouldHide = UserDefaults.standard.bool(forKey: "HideAmount") == true

        let imageName = shouldHide ? "phiHide" : "phiShow"
        if let image = UIImage(named: imageName) {
            let tintableImage = image.withRenderingMode(.alwaysTemplate)
            showHideButton.setImage(tintableImage, for: .normal)
            showHideButton.tintColor = UIColor.init(named: "phiGreen")
        }

        if shouldHide {
            self.amountLabel.text = "💸💸💸"
        } else if let amount = self.amountValue {
            self.amountLabel.text = String(format: "%.2f", amount)
        }
    }

    @IBAction func showHideButtonPressed(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "HideAmount") {
            UserDefaults.standard.setValue(false, forKey: "HideAmount")
        } else {
            UserDefaults.standard.setValue(true, forKey: "HideAmount")
        }
        setupAmountView()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.statementList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = StatementInfoTableViewCell.identifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? StatementInfoTableViewCell else {
            return UITableViewCell()
        }

        cell.transferValueLabel.text = String(self.statementList[indexPath.row].amount)
        cell.transferTypeLabel.text = self.statementList[indexPath.row].tType
        cell.transferDate.text = self.statementList[indexPath.row].createdAt
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        statementInfo = statementList[indexPath.row]
        performSegue(withIdentifier: "statementDetailSegue", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "statementDetailSegue" {
            guard let viewController = segue.destination as? StatementDetailViewController else {
                print(Error.self)
                return
            }
            viewController.statementInfo = statementInfo
        }
    }
}

//
//  ViewController.swift
//  Desafio_Somosphi
//
//  Created by Suh on 02/08/22.
//

import UIKit

class ExtractViewController: UIViewController {

    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var showAmountButton: UIButton!

    weak var coordinator: ExtractCoordinator?

    var model: ExtractModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
        updateAmount()
        model.fetchExtract()
        // showAmountButton?.setImage(Icon.eyeSlash.sfIcon, for: .normal)
    }

    @IBAction func showAmount(_ sender: UIButton) {
        model.changeAmountVisibility()
    }

    private func updateAmount() {
        balanceLabel?.text = model.formattedAmount
        if model.isAmountVisible == false {
            showAmountButton?.setImage(Icon.eyeSlash.sfIcon, for: .normal)
        } else {
            showAmountButton?.setImage(Icon.eye.sfIcon, for: .normal)
        }
    }
}

extension ExtractViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.extract.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell", for: indexPath
        ) as? ExtractTableViewCell else {
            fatalError()
        }
        let extract = model.extract[indexPath.row]
        cell.prepare(model: extract)
        return cell
    }

}

extension ExtractViewController: ExtractModelDelegate {
    func didUpdateBalance() {
        DispatchQueue.main.async { [weak self] in
            guard let selfRef = self else {
                return
            }
            selfRef.updateAmount()
        }
    }

    func didUpExtracts() {
        tableView.reloadData()
    }

}

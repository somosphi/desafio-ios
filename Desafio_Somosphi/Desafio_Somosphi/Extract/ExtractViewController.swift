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

    var model = ExtractModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        balanceLabel?.text = "--------"
        tableView?.dataSource = self
        // model.delegate = self // colocar na acao do button
        model.fetchExtract()
        showAmountButton?.setImage(Icon.eyeSlash.sfIcon, for: .normal)
    }

    @IBAction func showAmount(_ sender: UIButton) {
        updateAmount()

    }

    private func updateAmount() {
//        var eye = Icon.eyeSlash.sfIcon
//        self.showAmountButton?.setImage(eye, for: .normal)
//        switch eye {
//        case Icon.eyeSlash.sfIcon:
//            eye = Icon.eye.sfIcon
//        default:
//            eye = Icon.eyeSlash.sfIcon
//        }

        if model.isAmountVisible == false {
            showAmountButton?.setImage(Icon.eyeSlash.sfIcon, for: .normal)
        }
        if model.isAmountVisible {
            self.showAmountButton?.setImage(Icon.eye.sfIcon, for: .normal)
            self.balanceLabel?.text = self.model.formattedAmount
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
            selfRef.balanceLabel?.text = selfRef.model.formattedAmount

        }
    }

    func didUpExtracts() {
        tableView.reloadData()
    }

}

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
        tableView?.dataSource = self
        model.delegate = self // colocar na acao do button
        model.fetchExtract()
        updateAmount()
    }

    @IBAction func showAmount(_ sender: UIButton) {

    }

    private func updateAmount() {
        if model.isAmountVisible {
            showAmountButton?.setImage(Icon.eye.sfIcon, for: .normal)
            print("aberto")
        } else {
            showAmountButton?.setImage(Icon.eyeSlash.sfIcon, for: .normal)
            print("fechado")
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

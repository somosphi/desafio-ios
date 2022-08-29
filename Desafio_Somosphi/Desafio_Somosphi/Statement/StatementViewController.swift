//
//  ViewController.swift
//  Desafio_Somosphi
//
//  Created by Suh on 02/08/22.
//

import UIKit

protocol StatementViewControllerDelegate: AnyObject {
    func showDetailStatement(statementID: String)
}

class StatementViewController: UIViewController {

    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var showAmountButton: UIButton!

    weak var coordinator: StatementCoordinator?
    weak var delegate: StatementViewControllerDelegate?

    var model: StatementModel?
    var statements: [Statement] {
        model?.statements ?? []
    }

    var canShowLoading: Bool {
        model?.canShowLoading == true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Extrato"
        tableView?.dataSource = self
        tableView?.delegate = self
        updateAmount()
        model?.fetchStatement()
    }

    @IBAction func showAmount(_ sender: UIButton) {
        model?.changeAmountVisibility()
    }

    private func updateAmount() {
        balanceLabel?.text = model?.formattedAmount
        if model?.isAmountVisible == false {
            showAmountButton?.setImage(Icon.eyeSlash.sfIcon, for: .normal)
        } else {
            showAmountButton?.setImage(Icon.eye.sfIcon, for: .normal)
        }
    }
}

extension StatementViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if canShowLoading {
            return 2
        }
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statements.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if canShowLoading && indexPath.section == 1 {
            return makeLoadingCell(tableView: tableView, indexPath: indexPath)
        }
        return makeStatementCell(tableView: tableView, indexPath: indexPath)
    }

    private func makeStatementCell(tableView: UITableView, indexPath: IndexPath) -> StatementTableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell", for: indexPath
        ) as? StatementTableViewCell else {
            fatalError()
        }

        let statement = statements[indexPath.row]
        cell.prepare(model: statement)
        return cell
    }

    private func makeLoadingCell(tableView: UITableView, indexPath: IndexPath) -> LoadingCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "loading", for: indexPath
        ) as? LoadingCell else {
            fatalError()
        }
        return cell
    }

}

extension StatementViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let statement = statements[indexPath.row]
        delegate?.showDetailStatement(statementID: statement.statementID)

    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if statements.count - 1 == indexPath.row {
            self.model?.fetchStatement()
        }
    }
}

extension StatementViewController: StatementModelDelegate {
    func didUpdateBalance() {
        DispatchQueue.main.async { [weak self] in
            guard let selfRef = self else {
                return
            }
            selfRef.updateAmount()
        }
    }

    func didUpdateStatement() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    func didErrorRepositories() {
        print("E R R O R ! ! ! ! !")
    }

}

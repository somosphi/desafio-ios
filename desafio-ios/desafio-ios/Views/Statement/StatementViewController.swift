//
//  StatementViewController.swift
//  desafio-ios
//
//  Created by Gustavo Igor Gonçalves Travassos on 12/01/21.
//

import UIKit

// MARK: - Class

final class StatementViewController: BaseViewController<StatementView> {
    
    // MARK: - Private variables
    
    private let viewModel: StatementViewModel
    
    // MARK: - Initializer
    
    init(viewModel: StatementViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupTableView()
        addTargets()
        
        serviceGetBalance()
        serviceGetStatementList()
    }
}

extension StatementViewController {
    
    // MARK: - Private methods
    
    private func serviceGetBalance() {
        viewModel.getBalance() { [weak self] response in
            guard let self = self else { return }
            
            self.setupBalance(amount: response.amount)
        }
    }
    
    private func serviceGetStatementList() {
        viewModel.getStatementList() { [weak self] response in
            guard let self = self else { return }
        }
    }
    
    private func setupNavBar() {
        navigationItem.title = "Extrato"
    }
    
    private func setupBalance(amount: Double) {
        DispatchQueue.main.async {
            self.customView.amountLabel.text = "\(amount)"
        }
    }
    
    private func setupTableView() {
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
    }
    
    private func addTargets() {
        customView.revealButton.addTarget(self,
                                          action: #selector(didTapRevealButton),
                                          for: .touchUpInside)
    }
    
    @objc private func didTapRevealButton() {
        customView.toggleRevealButton()
    }
}

extension StatementViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatementTableViewCell.id, for: indexPath) as? StatementTableViewCell
        else {
            return .init()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
}

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
        
        setup()
    }
}

extension StatementViewController {
    
    // MARK: - Private methods
    
    private func setup() {
        setupNavBar()
        setupTableView()
        addTargets()
        
        serviceGetBalance()
        serviceGetStatementList()
    }
    
    private func serviceGetBalance() {
        customView.toggleRevealButton()
        
        viewModel.getBalance() { [weak self] response in
            guard let self = self else { return }
            self.setupBalance(amount: response.amount)
        }
    }
    
    private func serviceGetStatementList() {
        if let window = UIApplication.shared.windows.first {
            LoadingOverlay.shared.showOverlay(view: window)
        }
        
        viewModel.getStatementList() { [weak self] response in
            guard let self = self else { return }
            self.viewModel.model = response
            
            if response.items.isEmpty {
                self.showErrorOverlay()
            }
            
            self.reloadTableView()
            LoadingOverlay.shared.hideOverlayView()
        }
    }
    
    private func setupNavBar() {
        navigationItem.title = "Extrato"
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.customView.tableView.reloadData()
        }
    }
    
    private func showErrorOverlay() {
        DispatchQueue.main.async {
            ErrorOverlay.shared.showOverlay(view: self.customView.tableView,
                                            errorImage: UIImage(systemName: "xmark.octagon") ?? UIImage(),
                                            message: "Algo deu errado! \nTente novamente")
        }
    }
    
    private func setupBalance(amount: Double) {
        DispatchQueue.main.async {
            self.customView.amountLabel.text = String(amount).formatToCurrency
            self.customView.toggleRevealButton()
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
    
    // MARK: - TableView Delegate + DataSource
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = viewModel.model?.items[indexPath.row].id else { return }
        viewModel.goToDetail(id: id)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatementTableViewCell.id,
                                                       for: indexPath) as? StatementTableViewCell
        else {
            return UITableViewCell()
        }
        
        guard let statementArray = viewModel.model else { return UITableViewCell() }
        cell.setupLabel(statement: statementArray.items[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
}

//
//  StatementViewController.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import UIKit

class StatementViewController: UIViewController {
    
    weak var coordinator: StatementCoordinator?
    private var statementViewModel = StatementViewModel()
    private var balanceHeaderView = BalanceHeaderView()
    private var statementHeaderView = StatementsHeaderView()
    
    private let loadingActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .black
        indicator.startAnimating()
        indicator.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin,
            .flexibleTopMargin, .flexibleBottomMargin
        ]
        
        return indicator
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.isHidden = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewConfiguration()
        loadMyBalance()
        loadViewModel()
    }
    
    private func loadMyBalance() {
        self.statementViewModel.getMyBalance { statementViewModel in
            self.statementViewModel = statementViewModel
            DispatchQueue.main.async {
                self.balanceHeaderView.updateAmount(statementViewModel.amount)
                self.loadingActivityIndicator.stopAnimating()
            }
        }
    }
    
    private func loadViewModel() {
        self.statementViewModel.getStatement { statementViewModel in
            self.statementViewModel = statementViewModel
            DispatchQueue.main.async {
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StatementTableViewCell.self,
                           forCellReuseIdentifier: StatementTableViewCell.reusableIdentifier)
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "Extrato"
    }
    
}

extension StatementViewController: ViewConfiguration {
    
    func configureViews() {
        view.backgroundColor = .white
        
        loadingActivityIndicator.center = CGPoint(
            x: view.bounds.midX,
            y: view.bounds.midY
        )
        
        configureNavigation()
        configureTableView()
    }
    
    func buildViewHierarchy() {
        view.addSubview(tableView)
        view.addSubview(loadingActivityIndicator)
    }
    
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
}

extension StatementViewController: UITableViewDelegate {
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let transactionId = statementViewModel.getTransactionId(for: indexPath.row) else {
            return
        }
        
        self.coordinator?.startStatementDetail(transactionId: transactionId)
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return balanceHeaderView
        default:
            return statementHeaderView
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 100
        default:
            return 44
        }
    }
    
}

extension StatementViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return statementViewModel.numberOfTransactions
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let tableViewCell = tableView.dequeueReusableCell(
                withIdentifier: StatementTableViewCell.reusableIdentifier,
                for: indexPath) as? StatementTableViewCell, let statementDetail =
                    statementViewModel.getTransaction(for: indexPath.row) else {
            return UITableViewCell()
        }
        
        tableViewCell.setup(statementDetail: statementDetail)
        
        return tableViewCell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
}

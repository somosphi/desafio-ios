//
//  StatementViewController.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import UIKit

enum Section: Int, CaseIterable {
    case balance, statement
}

class StatementViewController: UIViewController {
    
    // MARK: - Properties
    
    typealias DataSource = UITableViewDiffableDataSource<Section, StatementDetailViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, StatementDetailViewModel>
    weak var coordinator: StatementCoordinator?
    private var statementViewModel = StatementViewModel()
    private var balanceHeaderView = BalanceHeaderView()
    private var statementHeaderView = StatementsHeaderView()
    private lazy var dataSource = makeDataSource()
    
    // MARK: - Views
    
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
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewConfiguration()
        loadMyBalance()
        loadViewModel()
    }
    
    // MARK: - Functions
    
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
                self.aplySnapshot(animatingDifferences: false)
                self.tableView.reloadData()
            }
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.register(StatementTableViewCell.self,
                           forCellReuseIdentifier: StatementTableViewCell.reusableIdentifier)
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "Extrato"
    }
    
    // MARK: - Data source
    
    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, statement in
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: StatementTableViewCell.reusableIdentifier,
                    for: indexPath) as? StatementTableViewCell else {
                return UITableViewCell()
            }
            cell.setup(statementDetail: statement)
            return cell
        })
       return dataSource
    }
    
    private func aplySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems([], toSection: .balance)
        snapshot.appendItems(statementViewModel.statement, toSection: .statement)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

// MARK: - ViewConfiguration

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

// MARK: - UITableViewDelegate

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

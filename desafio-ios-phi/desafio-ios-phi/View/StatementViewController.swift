//
//  StatementViewController.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import UIKit

enum Section: Int, CaseIterable {
    case statement
}

class StatementViewController: UIViewController {
    
    // MARK: - Properties
    
    typealias DataSource = UITableViewDiffableDataSource<Section, StatementDetailViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, StatementDetailViewModel>
    private var page: Int = 1
    private lazy var dataSource = makeDataSource()
    private var alertIsShowing = false
    
    // MARK: - Views
    
    weak var coordinator: StatementCoordinator?
    private var statementViewModel = StatementViewModel()
    private var headerView = HeaderView()
    private let refreshControl = UIRefreshControl()
    private let loadingActivityIndicator: UIActivityIndicatorView = ActivityIndicatorView(style: .large)
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 100
        tableView.estimatedSectionHeaderHeight = 200
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.isHidden = true
        return tableView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewConfiguration()
        loadViewModel()
    }
    
    // MARK: - Functions
    
    @objc private func loadViewModel() {
        loadMyBalance()
        loadStatements()
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Ocorreu um erro",
                                                message: "Não conseguimos processar sua solicitação. Tente novamente",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        if alertIsShowing {
            alertController.dismiss(animated: true, completion: nil)
            
        } else {
            self.alertIsShowing = true
            self.present(alertController, animated: true) {
                self.alertIsShowing = false
            }
        }
    }
    
    private func loadMyBalance() {
        self.statementViewModel.getMyBalance { (statementViewModel, error) in
            
            if error != nil, !self.alertIsShowing {
                DispatchQueue.main.async {
                    self.showAlert()
                    self.updateUI()
                }
                return
            }
        
            self.statementViewModel = statementViewModel
            DispatchQueue.main.async {
                self.headerView.updateAmount(statementViewModel.amount)
                self.updateUI()
            }
        }
    }
    
    private func loadStatements() {
        self.statementViewModel.getStatement(completion: { (statementViewModel, error) in
            
            if error != nil, !self.alertIsShowing {
                DispatchQueue.main.async {
                    self.showAlert()
                    self.updateUI()
                }
                return
            }
          
            self.statementViewModel = statementViewModel
            DispatchQueue.main.async {
                self.aplySnapshot(statementViewModel)
                self.updateUI()
                self.tableView.reloadData()
            }
        })
    }
    
    private func updateUI() {
        self.loadingActivityIndicator.stopAnimating()
        self.refreshControl.endRefreshing()
        self.tableView.isHidden = false
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        tableView.register(StatementTableViewCell.self,
                           forCellReuseIdentifier: StatementTableViewCell.reusableIdentifier)
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = STATEMENT
        
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
    
    private func aplySnapshot(_ statementViewModel: StatementViewModel) {
        var snapshot = Snapshot()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(statementViewModel.getAllTransactions(), toSection: .statement)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func updateSnapshot(_ statement: [StatementDetailViewModel]) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(statement, toSection: .statement)
        dataSource.apply(snapshot, animatingDifferences: false)
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
        refreshControl.addTarget(self, action: #selector(loadViewModel), for: .valueChanged)
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
        guard let statementDetailViewModel = statementViewModel.getStatementDetail(for: indexPath.row) else {
            return
        }
        
        self.coordinator?.startStatementDetail(statementDetailViewModel: statementDetailViewModel)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.height) {
            if statementViewModel.isPaginating {
                return
            }
            statementViewModel.getStatementWithPagination(pagination: true,
                                                          offset: page) { statementViewModel, newStatement in
                if !newStatement.isEmpty {
                    self.page += 1
                    self.statementViewModel = statementViewModel
                    DispatchQueue.main.async {
                        self.updateSnapshot(newStatement)
                    }
                }
            }
        }
    }
}

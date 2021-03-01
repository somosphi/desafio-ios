//
//  HomeViewController.swift
//  desafio-phi
//
//  Created by Marcus Vinicius Vieira Badiale on 25/02/21.
//

import UIKit

final class StatementViewController: BaseViewController<StatementView> {

    // MARK: - Private variables
    private let viewModel: StatementViewModel
    
    // MARK: - Init
    init(viewModel: StatementViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getBalance()
        getStatements()
    }
}

extension StatementViewController {
    
    // MARK: - Private methods
    private func setup() {
        title = "Extrato"
        
        setupTableView()
        addTargets()
        showLoadingIndicator()
    }
    
    private func showLoadingIndicator() {
        if let window = UIApplication.shared.windows.first {
            LoadingView.shared.showLoadingIndicator(view: window)
        }
    }
    
    private func setupTableView() {
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
    }
    
    private func addTargets() {
        customView.eyeButton.addTarget(self, action: #selector(didTapEyeButton), for: .touchUpInside)
    }
    
    private func getBalance() {
        viewModel.getMyBalance { [weak self] response in
            switch response {
            case .success(let balance):
                guard let balance = balance else {
                    return
                }
                
                self?.viewModel.balance = balance
                self?.customView.setBalanceAmount(value: balance.amount)
                
            case .failure(let error):
                print(error)
                //show error message
            }
        }
    }
    
    private func getStatements() {
        
        if !viewModel.isPaginating {
            
            viewModel.currentStatementPage += 1
            viewModel.isPaginating = true
            
            viewModel.getStatementList(offSet: viewModel.currentStatementPage) { [weak self] response in
                switch response {
                case .success(let statements):
                    guard let statements = statements else {
                        return
                    }
                    
                    self?.viewModel.statements.append(contentsOf: statements)
                    self?.customView.tableView.tableFooterView = nil
                    self?.customView.tableView.reloadData()
                    self?.viewModel.isPaginating = false
                    
                    LoadingView.shared.hideLoadingIndicator()
                    
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    //MARK: - Actions
    @objc private func didTapEyeButton() {
        customView.toggleBalanceVisibility()
    }
}

//MARK: - Table View
extension StatementViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .appGreen
        activityIndicator.center = footerView.center
        
        footerView.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        return footerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if position > (customView.tableView.contentSize.height - scrollView.frame.size.height) {
            
            if viewModel.isPaginating {
                return
            }
            
            customView.tableView.tableFooterView = createSpinnerFooter()
            
            getStatements()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.statements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatementTableViewCell.id,
                                                       for: indexPath) as? StatementTableViewCell else {
            return UITableViewCell()
        }
        
        let currentStatement = viewModel.statements[indexPath.row]
        
        cell.setupCell(transferText: currentStatement.description, forText: currentStatement.to ?? "",
                       value: currentStatement.value, date: currentStatement.createdAt, isPix: false)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentStatement = viewModel.statements[indexPath.row]
        viewModel.goToDetail(withId: currentStatement.id)
    }
}

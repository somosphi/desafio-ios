//
//  ViewController.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 29/12/20.
//

import UIKit

class HomeViewController: LoadingViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var balanceBackgroundView: UIView!
    @IBOutlet weak var balanceTitle: BaseLabel!
    @IBOutlet weak var hideBalanceButton: HideButton!
    @IBOutlet weak var balanceValue: LargeGreenLabel!
    @IBOutlet weak var hideBalanceView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    
    var headerView: UIView = UIView()
    var headerLabel: UILabel = UILabel()
    
    var viewModel: HomeViewModel?
    var coordinator: HomeCoordinator?
    
    var currentPage: Int = 1
    var firstLoaded: Bool = false
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = HomeViewModel(delegate: self)
        navigationItem.title  = StringConstants.statementTitle
        
        reload()
        setupBalanceView()
        setupTableView()
    }
    
    func reload(){
        viewModel?.getMyBalance()
        viewModel?.getMyStatement(page: currentPage)
        showLoadingPopup()
    }
    
    // MARK: - Setups
    
    func setupBalanceView(){
        balanceBackgroundView.backgroundColor = .appWhite
        hideBalanceView.backgroundColor = .appGreen
        balanceTitle.text = StringConstants.balanceTitle
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(type: StatementCell.self)
        tableView.separatorStyle = .none
    }
    
    // MARK: Actions
    
    @IBAction func hideButtonTouched(_ sender: Any) {
        hideBalanceButton.buttonTouched()
        updateBalanceHiddenStatus()
    }
    
    func updateBalanceHiddenStatus(){
        balanceValue.isHidden = hideBalanceButton.buttonIsHidden
        hideBalanceView.isHidden = !hideBalanceButton.buttonIsHidden
    }
    
}

// MARK: - UITableView Functions

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK:  Setup Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StatementCell = tableView.dequeueReusableCell(for: indexPath)
        cell.item = viewModel?.items[indexPath.row]
        cell.selectionStyle = .none
        
        if indexPath.row == 0 {
            cell.lineTopConstraint.constant = 10
        }
        
        return cell
    }
    
    // MARK: Did Selected Row
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = viewModel?.items[indexPath.row] else {
            return
        }
        coordinator?.goToStatementDetailScreen(statementId: item.id, bankName: item.bankName)
    }
    
    // MARK: Infine Scroll
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let count = viewModel?.items.count else {
            return
        }

        if indexPath.row == count - 2 {
            if firstLoaded {
                currentPage += 1
                viewModel?.getMyStatement(page: currentPage)
            } else {
                firstLoaded = true
            }
        }
    }
    
   
    // MARK: Setup Header
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if !(viewModel?.items.isEmpty ?? true) {
            headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
            headerLabel = MediumSemiboldLabel(frame: CGRect(x: 15, y: 5, width: headerView.frame.width, height: headerView.frame.height))
            headerLabel.text = StringConstants.statementTableViewHeaderTitle
            headerView.backgroundColor = .white
            headerView.addSubview(headerLabel)
            return headerView
        } else {
            headerView = UIView()
            headerView.backgroundColor = .white
            return headerView
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}

// MARK: - HomeViewModelDelegate Functions

extension HomeViewController: HomeViewModelDelegate {
    func didGetBalance(balance: Balance) {
        DispatchQueue.main.async {
            self.balanceTitle.isHidden = false
            self.hideBalanceButton.isHidden = false
            self.balanceValue.setCurrencyText(amount: Double(balance.amount))
            self.updateBalanceHiddenStatus()
        }
    }
    
    func didGetStatement() {
        DispatchQueue.main.async {
            self.hideLoadingPopup()
            self.tableView.reloadData()
            self.headerView.isHidden = false
        }
    }
    
    func failed(message: String) {
        self.hideLoadingPopup()
        self.present(message: message)
    }
}


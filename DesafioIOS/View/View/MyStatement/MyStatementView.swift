//
//  MyStatementView.swift
//  DesafioIOS
//
//

import UIKit
import Combine



class MyStatementView: UIView {
    
    // MARK: - Subviews
    private let containerStackView : UIStackView = {
        let stackView = UIStackViewBuilder(axis: .vertical)
            .withSpacing(5.0)
            .withAligment(.center)
            .withDistribution(.fill)
            .build()
        
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private let statementTitle = UILabel.createDynamicFontLabel(fontStyle: .title1,
                                                                defaultText: "Extrato")
    
    private let balanceView = BalanceView()
    
    private let statementsTableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(MyStatementItemTableViewCell.self, forCellReuseIdentifier: MyStatementItemTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        return tableView
    }()
    
    private let tableViewBackgroundSpinner =
        UIActivityIndicatorBuilder.create(style: .large)
    
    private let footerTableViewSpinner =
        UIActivityIndicatorBuilder.create(style: .large)
    
    // MARK: - Initialization
    init(){
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Delegates and observable
    weak var statementsTableViewDelegate : UITableViewDelegate?{
        didSet{
            self.statementsTableView.delegate =  statementsTableViewDelegate
        }
    }
    
    weak var statementsTableViewDataSource : UITableViewDataSource?{
        didSet{
            self.statementsTableView.dataSource =  statementsTableViewDataSource
        }
    }
    
    var showBalanceButtonPressedObservable : AnyPublisher<Void,Never> {
        return balanceView.showBalanceButtonPressedObservable
    }
    
    // MARK: Update API functions
    func updateBalance(balanceResult : Result<MyBalance,StatementLoadErrorViewModel>){
        self.balanceView.updateBalance(result: balanceResult)
    }
    
    
    func showBalanceToUser(_ showBalance : Bool){
        self.balanceView.showBalanceToUser(showBalance)
    }
    
    func startFooterSpinnerLoadingAnimation(){
        footerTableViewSpinner.startAnimating()
    }
    
    func stopFooterSpinnerLoadingAnimation(){
        footerTableViewSpinner.stopAnimating()
    }
    
    func startTableViewLoadingAnimation(){
        tableViewBackgroundSpinner.startAnimating()
    }
    
    func stopTableViewLoadingAnimation(){
        tableViewBackgroundSpinner.stopAnimating()
    }
    
    func reloadTableViewData(){
        self.statementsTableView.reloadData()
    }
    
}

extension MyStatementView : ViewConfiguration{
    func setupConstraints() {
        setupContainerStackConstraints()
        setupBalanceViewConstraints()
        setupStatementsTableViewConstraints()
    }
    
    func buildViewHierarchy() {
        containerStackView.addArrangedSubviewsInOrder(
            statementTitle,
            balanceView,
            statementsTableView)
        self.addSubview(containerStackView)
        
    }
    
    func configureViews() {
        self.backgroundColor = UIColor.whitePhi
        self.statementsTableView.backgroundView = tableViewBackgroundSpinner
        self.statementsTableView.tableFooterView = footerTableViewSpinner
    }
    
    private func setupContainerStackConstraints(){
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.constraintsForAnchoringToSafeArea(view: self).activate()
    }
    
    private func setupBalanceViewConstraints(){
        balanceView.translatesAutoresizingMaskIntoConstraints = false
        balanceView.widthAnchor.constraint(equalTo: containerStackView.widthAnchor)
            .activate()
    }
    
    private func setupStatementsTableViewConstraints(){
        statementsTableView.translatesAutoresizingMaskIntoConstraints = false
        statementsTableView.widthAnchor.constraint(equalTo: containerStackView.widthAnchor).activate()
    }
}

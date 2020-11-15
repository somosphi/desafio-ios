//
//  ViewController.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 09/11/20.
//

import UIKit

final class MainViewController: UIViewController {
    //MARK: - Properties
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        
        return tableView
    }()
    
    private lazy var tableHeaderView: BalanceHeader = {
       let header = BalanceHeader(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        
        return header
    }()
    
    private let presenter: MainPresenter
    
    //MARK: - Initialization
    
    init(presenter: MainPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
        presenter.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Object Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViewConfiguration()
        setup()
        presenter.viewDidload()
       
    }
    
    //MARK: - Functions
    
    private func setup() {
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        
        navigationController?.navigationBar.tintColor = .blackHex
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blackHex ?? UIColor.black]
        
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
        title = Main.title
        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    private func setupTableView() {
        tableView.register(StatementCell.self, forCellReuseIdentifier: StatementCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableHeaderView = tableHeaderView
    }
}

//MARK: - UITableViewDelegate Interface Implementation

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItemAt(id: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
}

//MARK: - UITableViewDataSource Interface Implementation

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.statements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatementCell.identifier) as? StatementCell else { return UITableViewCell() }
        
        let statements: Items = presenter.statements[indexPath.row]
        let cellPresenter = StatementCellPresenter(statements: statements)
        cell.attachPresenter(cellPresenter)
        
        let  selectedView = UIView()
        selectedView.backgroundColor = .lightGrayHex
        cell.selectedBackgroundView = selectedView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return MainHeaders.yourTransactions
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerInSection = view as? UITableViewHeaderFooterView
        headerInSection?.textLabel?.textColor = UIColor.blackHex
        headerInSection?.tintColor = .white
    }
    
    
}
//MARK: - MainScreenView Inteface Implementation
extension MainViewController: MainScreenView {
    
    func showLoader() {
        Loader.show(in: self)
    }
    
    func hideLoader() {
        Loader.hide()
    }
    
    func showError(message: String) {
        let alertAction = UIAlertAction(title: AlertAction.title, style: .default, handler: { [weak self] handler -> Void in
            self?.presenter.tryAgain()
    })
        showAlert(message: message, alertAction: alertAction)
    }
    
    func reloadTableViewData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func didUpdateBalance(of value: Int) {
        DispatchQueue.main.async  { [weak self] in 
            let headerPresenter = BalanceHeaderPresenter(balance: value)
            self?.tableHeaderView.attachPresenter(headerPresenter)
        }
    }
    
}


//MARK: - UIScrollViewDelegate Interface Implementation
extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let distanceToBottom = contentHeight - offsetY
       
        if distanceToBottom < tableView.frame.height && !presenter.isFetchingStatements {
            loadMoreStatementsFromServer()
        }
    }
    
    private func loadMoreStatementsFromServer() {
        presenter.fetchMyStatements()
    }
}

//MARK: - ViewConfiguration
extension MainViewController: ViewConfiguration {
    
    func setupConstraints() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    
}



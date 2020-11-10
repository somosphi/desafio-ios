//
//  ViewController.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 09/11/20.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    let service = ServiceLayer()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViewConfiguration()
        setup()
        service.requestMyBalance()
        service.requestMyStatement()
    }

    private func setup() {
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
        title = "Extrato"
        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    private func setupTableView() {
        tableView.register(StatementCell.self, forCellReuseIdentifier: StatementCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .white
        
        let header = MyBalanceHeader(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        tableView.tableHeaderView = header
    }
}

extension MainViewController: UITableViewDelegate {
    
    // tableView delegate
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatementCell.identifier) as? StatementCell else { return UITableViewCell()}
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     
        return "Suas Movimentações"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .white
    }
    
    
}

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

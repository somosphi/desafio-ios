//
//  StatementDetailViewController.swift
//  desafio-phi
//
//  Created by Marcus Vinicius Vieira Badiale on 26/02/21.
//

import UIKit

final class StatementDetailViewController: BaseViewController<StatementDetailView> {

    // MARK: - Private variables
    private let viewModel: StatementDetailViewModel
    
    // MARK: - Init
    init(viewModel: StatementDetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        getStatement()
    }
}

extension StatementDetailViewController {
    
    // MARK: - Private methods
    private func setup() {
        setupTableView()
        addTargets()
        showLoadingIndicator()
    }
    
    private func setupTableView() {
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
    }
    
    private func addTargets() {
        customView.shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
    }
    
    private func showLoadingIndicator() {
        if let window = UIApplication.shared.windows.first {
            LoadingView.shared.showLoadingIndicator(view: window)
        }
    }
    
    private func getStatement() {
        viewModel.getStatement { [weak self] response in
            switch response {
            case .success(let statement):
                guard let statement = statement else {
                    return
                }
                
                self?.viewModel.statement = statement
                self?.viewModel.setupDetailArray()
                self?.customView.tableView.reloadData()
                
                LoadingView.shared.hideLoadingIndicator()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func takeScreenshot(of view: UIView) {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: view.bounds.width,
                   height: view.bounds.height),
            false,
            2)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        view.layer.render(in: context)
        
        guard let screenshot = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        
        let activityViewController = UIActivityViewController(activityItems: [screenshot], applicationActivities: nil)
        self.present(activityViewController, animated: true)
    }
    
    //MARK: - Actions
    
    @objc func didTapShareButton() {
        takeScreenshot(of: customView.imageToBeShared)
    }
}

extension StatementDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.statementDetailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatementDetailTableViewCell.id,
                                                       for: indexPath) as? StatementDetailTableViewCell else {
            return UITableViewCell()
        }
        
        let currentData = viewModel.statementDetailArray[indexPath.row]
        
        cell.setupCell(title: currentData.title, description: currentData.description)
        
        return cell
    }
}

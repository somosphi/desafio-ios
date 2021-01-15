//
//  DetailViewController.swift
//  desafio-ios
//
//  Created by Gustavo Igor Gonçalves Travassos on 12/01/21.
//

import UIKit

// MARK: - Class

final class DetailViewController: BaseViewController<DetailView> {
    
    // MARK: - Private variables
    
    private let viewModel: DetailViewModel
    
    // MARK: - Initializer
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

extension DetailViewController {
    
    // MARK: - Private methods
    
    private func setup() {
        getStatement()
        setupNavBar()
        setupTableView()
        addTargets()
    }
    
    private func getStatement() {
        if let window = UIApplication.shared.windows.first {
            LoadingOverlay.shared.showOverlay(view: window)
        }
        
        viewModel.getStatementDetail() { [weak self] response in
            guard let self = self else { return }
            self.viewModel.model = response
            self.viewModel.setupDataArray()
            self.reloadTableView()
            
            LoadingOverlay.shared.hideOverlayView()
        }
    }
    
    @objc private func didTapShareButton() {
        takeScreenshot(of: customView.tableView)
    }
    
    private func setupNavBar() {
        navigationItem.title = "Comprovante"
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
    
    private func setupTableView() {
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
    }
    
    private func addTargets() {
        customView.shareButton.addTarget(self,
                                         action: #selector(didTapShareButton),
                                         for: .touchUpInside)
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
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.id,
                                                       for: indexPath) as? DetailTableViewCell
        else {
            return UITableViewCell()
        }
        
        let title = viewModel.dataArray[indexPath.row].title
        let content = viewModel.dataArray[indexPath.row].description
        cell.setupCellText(title: title, content: content)
        
        return cell
    }
}

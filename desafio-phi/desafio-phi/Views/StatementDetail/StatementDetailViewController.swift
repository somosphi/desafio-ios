//
//  StatementDetailViewController.swift
//  desafio-phi
//
//  Created by Marcus Vinicius Vieira Badiale on 26/02/21.
//

import UIKit

class StatementDetailViewController: BaseViewController<StatementDetailView> {

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
        navigationItem.backButtonTitle = ""
    }
    
    private func getStatement() {
        viewModel.getStatement { response in
            switch response {
            case .success(let statement):
                guard let statement = statement else {
                    return
                }
                print(statement)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

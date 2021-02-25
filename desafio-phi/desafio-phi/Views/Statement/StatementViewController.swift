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
    }
}

extension StatementViewController {
    
    // MARK: - Private methods
    private func setup() {
        print("viewDidLoad")
    }
}


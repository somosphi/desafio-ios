//
//  DetailViewController.swift
//  desafio-ios
//
//  Created by Gustavo Igor Gonçalves Travassos on 12/01/21.
//

import Foundation

// MARK: - Class

final class DetailViewController: BaseViewController<DetailView> {
    
    // MARK: - Private variables
    
    private let viewModel: DetailViewModel
    
    // MARK: - Initializer
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }
}

extension DetailViewController {}

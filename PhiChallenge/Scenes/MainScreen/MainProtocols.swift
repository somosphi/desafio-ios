//
//  MainProtocols.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 10/11/20.
//

import Foundation

public protocol ViewConfiguration: AnyObject {
    func setupConstraints()
    func buildViewHierarchy()
    func setupViewConfiguration()
}

extension ViewConfiguration {
    public func setupViewConfiguration() {
        buildViewHierarchy()
        setupConstraints()
    }
}

protocol MainScreenView: AnyObject {
    func showLoader()
    func hideLoader()
    func showError(message: String)
    func reloadTableViewData()
    func didUpdateBalance(of value: Int)
}

protocol StatementRoutering: AnyObject {
    func navigateToDetailsScene(id: String)
}

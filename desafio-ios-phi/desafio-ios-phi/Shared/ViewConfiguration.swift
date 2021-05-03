//
//  ViewConfiguration.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 03/05/21.
//

import Foundation
public protocol ViewConfiguration: AnyObject {
    func setupConstraints()
    func buildViewHierarchy()
    func configureViews()
    func setupViewConfiguration()
}

extension ViewConfiguration {
    public func setupViewConfiguration() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
}

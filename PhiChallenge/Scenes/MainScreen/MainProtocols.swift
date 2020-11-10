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
    func configureViews()
    func setupViewConfiguration()
}

extension ViewConfiguration {
    public func setupViewConfiguration() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    public func configureViews() {
        
    }
}

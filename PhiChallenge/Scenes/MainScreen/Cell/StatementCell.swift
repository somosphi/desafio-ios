//
//  StatementCell.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 10/11/20.
//

import UIKit

final class StatementCell: UITableViewCell {

    static let identifier = "StatementCell"

//MARK: - Object lifecycle
override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
   

    backgroundColor = .white
}

required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}

    func setup() {
        
    }
    
    
}

extension StatementCell: ViewConfiguration {
    
    func setupConstraints() {
        
    }
    
    func buildViewHierarchy() {
        
    }
    
    
    
}

//
//  StatementCell.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 10/11/20.
//

import UIKit

final class StatementCell: UITableViewCell {
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGrayHex
        
        return view
    }()
    
    private let ballView: UIView = {
        let view = UIView()
        view.backgroundColor = .cyanHex
        view.layer.cornerRadius = 7
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Transferência Enviada"
        label.textColor = .blackHex
        label.textAlignment = .left
        label.font = UIFont(name: Fonts.arial, size: 16)
        
        return label
    }()
    
    private let receiverlabel: UILabel = {
        let label = UILabel()
        label.text = "David Blond"
        label.textColor = .darkGrayHex
        label.textAlignment = .left
        label.font = UIFont(name: Fonts.arial, size: 15)
        
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "-R$ 100,00"
        label.textColor = .blackHex
        label.textAlignment = .left
        label.font = UIFont(name: Fonts.arialBold, size: 16)
        
        return label
    }()
    
    private let createAtlabel: UILabel = {
        let label = UILabel()
        label.text = "13/10"
        label.textColor = .darkGrayHex
        label.textAlignment = .center
        label.font = UIFont(name: Fonts.arial, size: 16)
        
        return label
    }()
    
    private let pixFlagLabel: UILabel = {
        let label = UILabel()
        label.text = "Pix"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: Fonts.arial, size: 12)
        label.backgroundColor = .cyanHex
        
        return label
        
    }()
    
    
    static let identifier = "StatementCell"

//MARK: - Object lifecycle
override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        setupViewConfiguration()
        setup()
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

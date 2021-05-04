//
//  StatementTableViewCell.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import UIKit

class StatementTableViewCell: UITableViewCell {
    static let reusableIdentifier = "StatementTableViewCell"
    
    var lineDetail: UIView = {
        let line = UIView()
        line.backgroundColor = .blackTextColor
        return line
    }()
    
    var circleDetail: UIView = {
        let circle = UIView()
        circle.backgroundColor = .blackTextColor
        circle.clipsToBounds = true
        circle.backgroundColor = .lightGreenColor
        circle.layer.cornerRadius = 7.5
        circle.layer.borderColor = UIColor.white.cgColor
        circle.layer.borderWidth = 2
        return circle
    }()
    
    var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .blackTextColor
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .grayTextColor
        nameLabel.textAlignment = .left
        return nameLabel
    }()
    
    var amountLabel: UILabel = {
        let amountLabel = UILabel()
        amountLabel.font = UIFont.boldSystemFont(ofSize: 17)
        amountLabel.textAlignment = .left
        amountLabel.textColor = .blackTextColor
        return amountLabel
    }()
    
    var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = .grayTextColor
        dateLabel.textAlignment = .right
        return dateLabel
    }()
    
    var customBackgroundView: UIView = {
        let customBackgroundView = UIView()
        customBackgroundView.backgroundColor = .whiteOffColor
        return customBackgroundView
    }()
    
    var pixLabel: UILabel = {
        let pixLabel = UILabel()
        pixLabel.text = "Pix"
        pixLabel.font = UIFont.systemFont(ofSize: 15)
        pixLabel.textColor = .white
        pixLabel.backgroundColor = .lightGreenColor
        pixLabel.textAlignment = .center
        return pixLabel
    }()

    func setup(statementDetail: StatementDetailViewModel) {
        titleLabel.text = statementDetail.description
        nameLabel.text = statementDetail.userName
        dateLabel.text = statementDetail.dateResume
        
        switch statementDetail.type {
        case .PIXCASHOUT, .TRANSFEROUT:
            amountLabel.text = "-" + statementDetail.amount
        default:
            amountLabel.text = statementDetail.amount
        }
        
        switch statementDetail.type {
        case .PIXCASHOUT, .PIXCASHIN:
            pixLabel.isHidden = false
            customBackgroundView.isHidden = false
        default:
            pixLabel.isHidden = true
            customBackgroundView.isHidden = true
        }
        
        setupViewConfiguration()
    }
    
    private func setupLineDetailConstraints() {
        lineDetail.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lineDetail.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lineDetail.heightAnchor.constraint(equalTo: heightAnchor),
            lineDetail.widthAnchor.constraint(equalToConstant: 0.5),
            lineDetail.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupCustomBackgroundConstraints() {
        customBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            customBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customBackgroundView.heightAnchor.constraint(equalToConstant: 100),
            customBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: customBackgroundView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: lineDetail.leadingAnchor, constant: 20)
        ])
    }
    
    private func setupPixLabelConstraints() {
        pixLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pixLabel.topAnchor.constraint(equalTo: customBackgroundView.topAnchor, constant: 10),
            pixLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            pixLabel.widthAnchor.constraint(equalToConstant: 50),
            pixLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupNameLabelConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
    }
    
    private func setupCircleDetailConstraints() {
        circleDetail.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            circleDetail.centerXAnchor.constraint(equalTo: lineDetail.centerXAnchor),
            circleDetail.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            circleDetail.widthAnchor.constraint(equalToConstant: 15),
            circleDetail.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    private func setupDateLabelConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            dateLabel.centerXAnchor.constraint(equalTo: pixLabel.centerXAnchor)
        ])
    }
    
    private func setupAmountLabelConstraints() {
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            amountLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            amountLabel.bottomAnchor.constraint(equalTo: customBackgroundView.bottomAnchor, constant: -10)
        ])
    }
}

extension StatementTableViewCell: ViewConfiguration {
    
    func configureViews() {
        backgroundColor = .white
        selectionStyle = .none
    }
    
    func setupConstraints() {
        setupLineDetailConstraints()
        setupCustomBackgroundConstraints()
        setupTitleLabelConstraints()
        setupPixLabelConstraints()
        setupNameLabelConstraints()
        setupCircleDetailConstraints()
        setupDateLabelConstraints()
        setupAmountLabelConstraints()
    }
    
    func buildViewHierarchy() {
        addSubview(customBackgroundView)
        addSubview(lineDetail)
        addSubview(circleDetail)
        addSubview(titleLabel)
        addSubview(pixLabel)
        addSubview(nameLabel)
        addSubview(dateLabel)
        addSubview(amountLabel)
    }
}

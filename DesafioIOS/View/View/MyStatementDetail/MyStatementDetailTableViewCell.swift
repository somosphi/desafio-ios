//
//  MyStatementDetailTableViewCell.swift
//  DesafioIOS
//
//

import UIKit

class MyStatementDetailTableViewCell: UITableViewCell, CellIdentifiable {
    
    static var identifier: String = "MyStatementDetailTableViewCell"
    
    // MARK: - Subviews
    private let containerStackView = UIStackViewBuilder(axis: .vertical).withSpacing(5)
        .withAligment(.leading).withDistribution(.fill).build()
    
    private let titleLabel = UILabel.createDynamicFontLabel(fontStyle: .headline)
    private let valueLabel = UILabel.createDynamicFontLabel(fontStyle: .subheadline)
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Update functions API
    func updateWith(model : MyStatementDetailItem){
        self.titleLabel.text = model.title
        self.valueLabel.text = model.value
    }
    
}

extension MyStatementDetailTableViewCell : ViewConfiguration{
    func setupConstraints() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.constraintsForAnchoringToSafeArea(view: contentView,
                                                             padding: 10).activate()
    }
    
    func buildViewHierarchy() {
        containerStackView.addArrangedSubviewsInOrder(titleLabel,valueLabel)
        self.contentView.addSubview(containerStackView)
    }
    
    func configureViews() {
        self.backgroundColor = UIColor.whitePhi
    }
    
    
}

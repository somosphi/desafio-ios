//
//  StatementTableViewCell.swift
//  DesafioIOS
//
//

import UIKit


class MyStatementItemTableViewCell: UITableViewCell, CellIdentifiable {
    
    static var identifier: String = "StatementTableViewCell"
    
    // MARK: -Subviews
    
    private let containerStackView = UIStackViewBuilder(axis: .horizontal)
        .withSpacing(5)
        .withAligment(.leading)
        .withDistribution(.fill).build()
    
    private let leadingImage = StatementTableViewCellImage()
    
    private let dataStackView : UIStackView = {
        let stackView = UIStackViewBuilder(axis: .horizontal)
        .withSpacing(5)
        .withAligment(.leading)
        .withDistribution(.equalSpacing).build()
        
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    // First column of data
    
    private let firstDataColumn = UIStackViewBuilder(axis: .vertical)
        .withSpacing(5)
        .withAligment(.leading)
        .withDistribution(.equalSpacing).build()
    
    private let descriptionLabel = UILabel.createDynamicFontLabel(fontStyle: .headline)
    private let destinationLabel = UILabel.createDynamicFontLabel(fontStyle: .subheadline)
    private let amountOfMoneyLabel = UILabel.createDynamicFontLabel(fontStyle: .caption1)
    
    // Second column of data
    private let seconDataColumn = UIView()
    
    private let dateLabel =  UILabel.createDynamicFontLabel(fontStyle: .subheadline)
    private let pixLabel : UILabel = {
        let label = UILabel.createDynamicFontLabel(fontStyle: .footnote, defaultText: "Pix")
        label.backgroundColor = UIColor.greenPhi
        label.textColor = UIColor.whitePhi
        label.textAlignment = .center
        return label
    }()
    
    // background view that is shown when statement is a pix
    private let pixBackgroundView = UIView()
    
    
    // MARK: - Initialization
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }
    
    // MARK: Update API functions
    
    func updateWith(statementItem : MyStatementItem){
        self.descriptionLabel.text = statementItem.description
        self.destinationLabel.text = statementItem.destination
        self.dateLabel.text = statementItem.creationDate
        self.amountOfMoneyLabel.text = "\(statementItem.amountOfMoney)"
        setupPersonalizedViewFor(type: statementItem.type)
    }
    
    private func setupPersonalizedViewFor(type : StatementType){
        if(type == .PIX){
            pixLabel.isHidden = false
            pixBackgroundView.backgroundColor = UIColor.whitePhi
        } else{
            pixLabel.isHidden = true
            pixBackgroundView.backgroundColor = UIColor.clear
        }
    }

}

extension MyStatementItemTableViewCell : ViewConfiguration{
    func setupConstraints() {
        setupContainerStackViewConstraints()
        setupLeadingImageConstraints()
        setupPixBackgroundViewConstraints()
        setupSecondDataColumnConstraints()
    }
    
    func buildViewHierarchy() {
        buildDataStackViewHierarchy()
        buildContainerStackViewHierarchy()
        buildCellContentViewHierarchy()
    }
    
    func configureViews() {
        self.layoutMargins = .zero
    }
    
    private func setupContainerStackViewConstraints(){
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.constraintsForAnchoringToSafeArea(view: contentView).activate()
    }
    
    private func setupLeadingImageConstraints(){
        leadingImage.translatesAutoresizingMaskIntoConstraints = false
        [leadingImage.widthAnchor.constraint(equalToConstant: 20),
         leadingImage.heightAnchor.constraint(equalTo: containerStackView.heightAnchor)].activate()
    }
    
    
    private func setupPixBackgroundViewConstraints(){
        pixBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        pixBackgroundView.constraintsForAnchoringTo(view: contentView, top: 2, bottom: 2).activate()
    }
    
    private func setupSecondDataColumnConstraints(){
        seconDataColumn.translatesAutoresizingMaskIntoConstraints = false
        seconDataColumn.widthAnchor.constraint(equalToConstant: 50).activate()
        setupPixLabelConstraints()
        setupDateLabelConstraints()
    }
    
    private func setupPixLabelConstraints(){
        [pixLabel,descriptionLabel].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        [pixLabel.widthAnchor.constraint(equalTo: seconDataColumn.widthAnchor),
        pixLabel.centerXAnchor.constraint(equalTo: seconDataColumn.centerXAnchor),
        pixLabel.heightAnchor.constraint(equalTo: descriptionLabel.heightAnchor),
        pixLabel.centerYAnchor.constraint(equalTo: descriptionLabel.centerYAnchor)].activate()
    }
    
    private func setupDateLabelConstraints(){
        [dateLabel, destinationLabel].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        dateLabel.centerYAnchor.constraint(equalTo: destinationLabel.centerYAnchor).activate()
        
        let topAnchor = dateLabel.topAnchor.constraint(greaterThanOrEqualTo: pixLabel.bottomAnchor, constant: 2)
        let centerX = dateLabel.centerXAnchor.constraint(equalTo: seconDataColumn.centerXAnchor)
        centerX.setLessPriorityThan(otherConstraint: topAnchor)
        
        [topAnchor,centerX].activate()
    }
    
    private func buildDataStackViewHierarchy(){
        firstDataColumn.addArrangedSubviewsInOrder(descriptionLabel,destinationLabel,amountOfMoneyLabel)
        seconDataColumn.addSubview(pixLabel)
        seconDataColumn.addSubview(dateLabel)
        dataStackView.addArrangedSubviewsInOrder(firstDataColumn, seconDataColumn)
    }
    
    private func buildContainerStackViewHierarchy(){
        containerStackView.addArrangedSubviewsInOrder(leadingImage,dataStackView)
    }
    
    private func buildCellContentViewHierarchy(){
        self.contentView.addSubview(pixBackgroundView)
        self.contentView.addSubview(containerStackView)
    }
}

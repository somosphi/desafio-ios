//
//  MyStatemementTableViewHeader.swift
//  DesafioIOS
//
//

import UIKit

class MyStatementTableViewHeader: UIView {
    // MARK: - Subviews
    private let titleLabel = UILabel.createDynamicFontLabel(fontStyle: .headline)
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Update API functions
    func updateWith(title : String){
        titleLabel.text = title
    }
}

extension MyStatementTableViewHeader : ViewConfiguration{
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.constraintsForAnchoringToSafeArea(view: self,padding: 5).activate()
    }
    
    func buildViewHierarchy() {
        self.addSubview(titleLabel)
    }
    
    func configureViews() {
        self.backgroundColor = .white
    }
}

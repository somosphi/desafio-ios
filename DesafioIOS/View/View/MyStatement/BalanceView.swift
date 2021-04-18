//
//  BalanceView.swift
//  DesafioIOS
//
//

import UIKit
import Combine

class BalanceView: UIView {
    // MARK: - SubViews
    private let containerStackView = UIStackViewBuilder(axis: .vertical)
        .withAligment(.leading)
        .withDistribution(.fill)
        .withSpacing(5.0).build()
    
    private let firstLineStack = UIStackViewBuilder(axis: .horizontal)
        .withAligment(.leading)
        .withDistribution(.fill)
        .withSpacing(5.0).build()
    
    private let titleLabel = UILabel.createDynamicFontLabel(
        fontStyle: .headline, defaultText: "Seu saldo")
        
    private let hideBalanceIcon = UIImage(systemName: "eye.slash.fill")
    private let showBalanceIcon = UIImage(systemName: "eye.fill")
    
    private let showBalanceButton : UIButton = {
        let button = UIButton()
        button.tintColor = UIColor.greenPhi
        return button
    }()
    
    // MARK: - Balance Value View
    private let balanceValueView = UIView()
    
    private let hideBalanceView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.greenPhi
        return view
    }()
    private let balanceValueLabel : UILabel = {
        let label = UILabel.createDynamicFontLabel(fontStyle: .headline)
        label.textColor = UIColor.greenPhi
        return label
    }()
    
    // MARK: - Observables
    var showBalanceButtonPressedObservable : AnyPublisher<Void,Never>{
        return showBalanceButtonPressedSubject.eraseToAnyPublisher()
    }
    private let showBalanceButtonPressedSubject = PassthroughSubject<Void,Never>()
    
    // MARK: - Initialization
    init(){
        super.init(frame: .zero)
        setupViewConfiguration()
        actions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Update API functions
    
    func updateBalance(result : Result<MyBalance,StatementLoadErrorViewModel>){
        switch result {
            case .success(let myBalance):
                self.balanceValueLabel.text = myBalance.value
                
            case .failure(let error):
                self.balanceValueLabel.text = error.shortDescription
        }
    }
    
    func showBalanceError(errorMessage : String){
        balanceValueLabel.text = errorMessage
    }
    
    func showBalanceToUser(_ showBalance : Bool){
        balanceValueLabel.isHidden = !showBalance
        hideBalanceView.isHidden = showBalance
        let showBalanceButtonImage = showBalance ? hideBalanceIcon : showBalanceIcon
        showBalanceButton.setBackgroundImage(showBalanceButtonImage, for: .normal)
    }
    
    // MARK: - Actions
    private func actions(){
        showBalanceButton.addTarget(self, action: #selector(showBalanceButtonWasPressed), for: .touchUpInside)
    }
    
    @objc private func showBalanceButtonWasPressed(){
        showBalanceButtonPressedSubject.send()
    }
}

extension BalanceView : ViewConfiguration{
    
    func setupConstraints() {
        setupContainerConstraints()
        setupBalanceValueViewConstraints()
    }
    
    func buildViewHierarchy() {
        buildBalanceValueViewHierarchy()
        firstLineStack.addArrangedSubviewsInOrder(titleLabel,showBalanceButton)
        containerStackView.addArrangedSubviewsInOrder(firstLineStack,balanceValueView)
        self.addSubview(containerStackView)
    }
    
    private func buildBalanceValueViewHierarchy(){
        balanceValueView.addSubview(balanceValueLabel)
        balanceValueView.addSubview(hideBalanceView)
    }
    
    private func setupContainerConstraints(){
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.constraintsForAnchoringToSafeArea(view: self,
                                                             padding: 10).activate()
    }
    
    private func setupBalanceValueViewConstraints(){
        balanceValueView.translatesAutoresizingMaskIntoConstraints = false
        
        [balanceValueView.widthAnchor.constraint(equalTo: containerStackView.widthAnchor),
         balanceValueView.heightAnchor.constraint(equalToConstant: 50)].activate()
        
        setupHideBalanceViewConstraints()
        setupBalanceValueLabelConstraints()
    }
    
    private func setupHideBalanceViewConstraints(){
        hideBalanceView.translatesAutoresizingMaskIntoConstraints = false
        [hideBalanceView.widthAnchor.constraint(equalToConstant: 100),
        hideBalanceView.heightAnchor.constraint(equalToConstant: 7),
        hideBalanceView.centerYAnchor.constraint(equalTo: balanceValueView.centerYAnchor),
        hideBalanceView.leadingAnchor.constraint(equalTo: balanceValueView.leadingAnchor)]
            .activate()
    }
    
    private func setupBalanceValueLabelConstraints(){
        balanceValueLabel.translatesAutoresizingMaskIntoConstraints = false
        [balanceValueLabel.centerYAnchor.constraint(equalTo: balanceValueView.centerYAnchor),
         balanceValueLabel.leadingAnchor.constraint(equalTo: balanceValueView.leadingAnchor)]
            .activate()
    }
}


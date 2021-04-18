//
//  MyStatementDetailView.swift
//  DesafioIOS
//
//

import UIKit
import Combine

class MyStatementDetailView: UIView {
    
    // MARK: - Subviews
    
    private let containerStackView = UIStackViewBuilder(axis: .vertical)
        .withSpacing(10)
        .withDistribution(.fill)
        .withAligment(.leading).build()
    
    private let tableViewLoadSpinner = UIActivityIndicatorBuilder.create(style: .large)
    
    private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(
            MyStatementDetailTableViewCell.self,
            forCellReuseIdentifier: MyStatementDetailTableViewCell.identifier)
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.whitePhi
        return tableView
    }()
    
    private let shareButton : UIButton = {
        let button = UIButton()
        button.setTitle("Compartilhar" , for: .normal)
        button.tintColor = UIColor.black
        button.backgroundColor = UIColor.greenPhi
        return button
    }()
    
    // MARK: - Initialization
    init(){
        super.init(frame: .zero)
        setupViewConfiguration()
        actions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Delegates and observable
    weak var tableViewDelegate : UITableViewDelegate?{
        didSet{
            self.tableView.delegate =  tableViewDelegate
        }
    }
    
    weak var tableViewDataSource : UITableViewDataSource?{
        didSet{
            self.tableView.dataSource =  tableViewDataSource
        }
    }
    
    var shareButtonPressedObservable : AnyPublisher<Void,Never>{
        return shareButtonPressedSubject.eraseToAnyPublisher()
    }
    
    private let shareButtonPressedSubject = PassthroughSubject<Void,Never>()
    
    // MARK: - Actions
    private func actions(){
        shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
    }
    
    @objc private func shareButtonPressed(){
        shareButtonPressedSubject.send()
    }
    
    // MARK: - Update functions API
    func createStatementImage() -> UIImage{
        tableView.reloadData()
        return self.asImage()
    }
    
    func startLoadingAnimation(){
        tableViewLoadSpinner.startAnimating()
    }
    
    func stopLoadingAnimation(){
        tableViewLoadSpinner.stopAnimating()
    }
    
}

extension MyStatementDetailView : ViewConfiguration{
    func setupConstraints() {
        setupContainerStackViewConstraints()
        setupTableViewConstraints()
        setupShareButtonConstraints()
    }
    
    func buildViewHierarchy() {
        containerStackView.addArrangedSubviewsInOrder(tableView,shareButton)
        self.addSubview(containerStackView)
    }
    
    func configureViews() {
        self.backgroundColor = UIColor.whitePhi
        tableView.backgroundView = tableViewLoadSpinner
    }
    
    private func setupShareButtonConstraints(){
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        [shareButton.widthAnchor.constraint(equalTo: containerStackView.widthAnchor),
         shareButton.heightAnchor.constraint(equalToConstant: 50)].activate()
    }
    
    private func setupContainerStackViewConstraints(){
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.constraintsForAnchoringToSafeArea(view: self,padding: 10)
            .activate()
    }
    
    private func setupTableViewConstraints(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.widthAnchor.constraint(equalTo: containerStackView.widthAnchor).activate()
    }
}

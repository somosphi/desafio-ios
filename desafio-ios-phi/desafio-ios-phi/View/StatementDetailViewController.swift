//
//  StatementDetailViewController.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import UIKit

class StatementDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private var statementDetailViewModel: StatementDetailViewModel
    private var myNavigationController: UINavigationController
    
    // MARK: - Views
    
    private var viewDescription: StatementDetailView?
    private var viewAmount: StatementDetailView?
    private var viewUserName: StatementDetailView?
    private var viewBankName: StatementDetailView?
    private var viewDateHour: StatementDetailView?
    private var viewAuthentication: StatementDetailView?
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceHorizontal = false
        return scrollView
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.backgroundColor = .white
        stackView.isHidden = true
        stackView.spacing = 10
        return stackView
    }()
    
    private let loadingActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .black
        indicator.startAnimating()
        indicator.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin,
            .flexibleTopMargin, .flexibleBottomMargin
        ]
        
        return indicator
    }()
    
    var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Comprovante"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textColor = .darkText
        return titleLabel
    }()
    
    private var dividingLine: UIView = {
        var dividingLine = UIView()
        dividingLine.backgroundColor = .grayTextColor
        return dividingLine
    }()
    
    private var shareButton: UIButton = {
        let shareButton = UIButton()
        shareButton.backgroundColor = .lightGreenColor
        shareButton.setTitle("Compartilhar", for: .normal)
        shareButton.titleLabel?.textColor = .white
        shareButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        return shareButton
    }()
    
    // MARK: - Initialization
    
    init(statementDetailViewModel: StatementDetailViewModel, navigationController: UINavigationController) {
        self.myNavigationController = navigationController
        self.statementDetailViewModel = StatementDetailViewModel(statementDetailViewModel: statementDetailViewModel)
        super.init(nibName: nil, bundle: nil)
        self.configureNavigation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadViewModel()
    }
    
    // MARK: - Functions
    
    private func loadViewModel() {
        self.statementDetailViewModel.get { statementViewModel in
            self.statementDetailViewModel = statementViewModel
            
            DispatchQueue.main.async {
                self.setupProperties()
                self.setupViewConfiguration()
                self.stackView.isHidden = false
                self.loadingActivityIndicator.stopAnimating()
                self.view.layoutIfNeeded()
            }
        }
        
    }
    
    private func configureNavigation() {
        myNavigationController.navigationBar.topItem?.title = ""
        myNavigationController.navigationBar.tintColor = .darkText
    }
    
    private func setupProperties() {
        
        if let description = statementDetailViewModel.description {
            viewDescription = StatementDetailView()
            viewDescription?.configureLayout(title: "Tipo de movimentação",
                                             subtitle: description)
        }
        
        if let amount = statementDetailViewModel.amount {
            viewAmount = StatementDetailView()
            viewAmount?.configureLayout(title: "Valor",
                                        subtitle: amount)
        }
        
        if let userName = statementDetailViewModel.userName {
            viewUserName = StatementDetailView()
            switch statementDetailViewModel.type {
            case .BANKSLIPCASHIN, .TRANSFERIN, .PIXCASHIN:
                viewUserName?.configureLayout(title: "Rementente",
                                              subtitle: userName)
            default:
                viewUserName?.configureLayout(title: "Recebedor",
                                              subtitle: userName)
            }
        }
        
        if let bankName = statementDetailViewModel.bankName {
            viewBankName = StatementDetailView()
            viewBankName?.configureLayout(title: "Instituição bancária", subtitle: bankName)
        }
        
        if let date = statementDetailViewModel.date {
            viewDateHour = StatementDetailView()
            viewDateHour?.configureLayout(title: "Data/Hora",
                                          subtitle: date)
        }
        
        if let authentication = statementDetailViewModel.authentication {
            viewAuthentication = StatementDetailView()
            viewAuthentication?.configureLayout(title: "Autenticação",
                                                subtitle: authentication)
        }
    }
    
    private func setupShareButtonConstraints() {
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shareButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            shareButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            shareButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: scrollView.trailingAnchor),
            titleLabel.leadingAnchor.constraint(lessThanOrEqualTo: scrollView.leadingAnchor)
        ])
    }
    
    private func setupDividingLineConstraints() {
        dividingLine.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dividingLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            dividingLine.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            dividingLine.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.90),
            dividingLine.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    private func setupStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: dividingLine.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor, constant: -100)
        ])
    }
    
    private func setupViewDescriptionConstraints() {
        guard let viewDescription = viewDescription else {
            return
        }

        viewDescription.translatesAutoresizingMaskIntoConstraints = false
        viewDescription.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
    }

    private func setupViewAmountConstraints() {
        guard let viewAmount = viewAmount else {
            return
        }

        viewAmount.translatesAutoresizingMaskIntoConstraints = false
        viewAmount.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
    }

    private func setupViewUserNameConstraints() {
        guard let viewUserName = viewUserName else {
            return
        }

        viewUserName.translatesAutoresizingMaskIntoConstraints = false
        viewUserName.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
    }

    private func setupViewBankNameConstraints() {
        guard let viewBankName = viewBankName else {
            return
        }

        viewBankName.translatesAutoresizingMaskIntoConstraints = false
        viewBankName.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
    }

    private func setupViewDateHourConstraints() {
        guard let viewDateHour = viewDateHour else {
            return
        }

        viewDateHour.translatesAutoresizingMaskIntoConstraints = false
        viewDateHour.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
    }

    private func setupViewAuthenticationConstraints() {
        guard let viewAuthentication = viewAuthentication else {
            return
        }

        viewAuthentication.translatesAutoresizingMaskIntoConstraints = false
        viewAuthentication.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        
    }
    
}

// MARK: - ViewConfiguration

extension StatementDetailViewController: ViewConfiguration {
    func setupConstraints() {
        setupShareButtonConstraints()
        setupScrollViewConstraints()
        setupStackViewConstraints()
        setupTitleLabelConstraints()
        setupDividingLineConstraints()
        setupViewDescriptionConstraints()
        setupViewAmountConstraints()
        setupViewUserNameConstraints()
        setupViewBankNameConstraints()
        setupViewDateHourConstraints()
        setupViewAuthenticationConstraints()
    }
    
    func buildViewHierarchy() {
        view.addSubview(scrollView)
        view.addSubview(shareButton)
        
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(dividingLine)
        scrollView.addSubview(loadingActivityIndicator)
        scrollView.addSubview(stackView)
    
        if let viewDescription = viewDescription {
            stackView.addArrangedSubview(viewDescription)
        }
        
        if let viewAmount = viewAmount {
            stackView.addArrangedSubview(viewAmount)
        }
        
        if let viewUserName = viewUserName {
            stackView.addArrangedSubview(viewUserName)
        }
        
        if let statementBankName = viewBankName {
            stackView.addArrangedSubview(statementBankName)
        }
        
        if let viewDateHour = viewDateHour {
            stackView.addArrangedSubview(viewDateHour)
        }
        
        if let viewAuthentication = viewAuthentication {
            stackView.addArrangedSubview(viewAuthentication)
        }
    }
    
    func configureViews() {
        loadingActivityIndicator.center = CGPoint(
            x: view.bounds.midX,
            y: view.bounds.midY
        )
    }
}

//
//  StatementDetailViewController.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes on 27/04/21.
//

import UIKit
import LinkPresentation

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
    private var scrollView = UIScrollView()
    private var activityViewController: UIActivityViewController?
    private let loadingActivityIndicator: UIActivityIndicatorView = ActivityIndicatorView(style: .large)
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.backgroundColor = .white
        stackView.spacing = 20
        return stackView
    }()
  
    var titleLabel: UILabel = MyLabel(textColor: .blackTextColor,
                                      font: UIFont.boldSystemFont(ofSize: 17),
                                      text: STATEMENTDETAIL,
                                      alignment: .center)

    private var dividingLine: UIView = {
        var dividingLine = UIView()
        dividingLine.backgroundColor = .grayTextColor
        return dividingLine
    }()
    
    private var shareButton: UIButton = {
        let shareButton = UIButton()
        shareButton.backgroundColor = .lightGreenColor
        shareButton.setTitle(SHAREBUTTONTITLE, for: .normal)
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
        setupLoadingActivityIndicator()
        loadViewModel()
    }
    
    // MARK: - Functions
    
    private func loadViewModel() {
        self.statementDetailViewModel.get { statementViewModel in
            self.statementDetailViewModel = statementViewModel
            
            DispatchQueue.main.async {
                self.setupProperties()
                self.setupViewConfiguration()
                self.loadingActivityIndicator.stopAnimating()
            }
        }
        
    }
    
    private func configureNavigation() {
        myNavigationController.navigationBar.topItem?.title = ""
        myNavigationController.navigationBar.tintColor = .darkText
        self.view.backgroundColor = .white
    }
    
    private func setupLoadingActivityIndicator() {
        view.addSubview(loadingActivityIndicator)
        loadingActivityIndicator.center = CGPoint(
            x: view.bounds.midX,
            y: view.bounds.midY
        )
    }
    
    @objc func share() {
        guard let activityViewController = activityViewController else {
            return
        }
        DispatchQueue.main.async {
            self.present(activityViewController, animated: true, completion: nil)
        }
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
        
        if !FileManagerPersistence.shared.fileExists(fileName: statementDetailViewModel.sharedName) {
            let imageForShare = stackView.renderViewToUIImage
            FileManagerPersistence.shared.saveImage(image: imageForShare,
                                                    imageName: statementDetailViewModel.sharedName)
        }
       
        activityViewController = UIActivityViewController(activityItems: [self],
                                                              applicationActivities: [])
        
        activityViewController?.popoverPresentationController?.sourceView = shareButton
        
    }
    
    // MARK: - Setup Constraints
    
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
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor, constant: -100)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        ])
    }
    
    private func setupDividingLineConstraints() {
        dividingLine.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dividingLine.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.90),
            dividingLine.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    private func setupViewDescriptionConstraints() {
        guard let viewDescription = viewDescription else {
            return
        }
        
        viewDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewDescription.heightAnchor.constraint(greaterThanOrEqualToConstant: 70),
            viewDescription.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
    
    private func setupViewAmountConstraints() {
        guard let viewAmount = viewAmount else {
            return
        }
        
        viewAmount.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewAmount.heightAnchor.constraint(greaterThanOrEqualToConstant: 70),
            viewAmount.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
    
    private func setupViewUserNameConstraints() {
        guard let viewUserName = viewUserName else {
            return
        }
        
        viewUserName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewUserName.heightAnchor.constraint(greaterThanOrEqualToConstant: 70),
            viewUserName.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
    
    private func setupViewBankNameConstraints() {
        guard let viewBankName = viewBankName else {
            return
        }
        
        viewBankName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewBankName.heightAnchor.constraint(greaterThanOrEqualToConstant: 70),
            viewBankName.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
    
    private func setupViewDateHourConstraints() {
        guard let viewDateHour = viewDateHour else {
            return
        }
        
        viewDateHour.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewDateHour.heightAnchor.constraint(greaterThanOrEqualToConstant: 70),
            viewDateHour.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
    
    private func setupViewAuthenticationConstraints() {
        guard let viewAuthentication = viewAuthentication else {
            return
        }
        
        viewAuthentication.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewAuthentication.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            viewAuthentication.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
        
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
        
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dividingLine)
        
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
        shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
    }
    
    func getMetadataForSharingManually(title: String) -> LPLinkMetadata {
        
        let linkMetaData = LPLinkMetadata()
        linkMetaData.title = title
        return linkMetaData
    }
}

// MARK: - UIActivityItemSource

extension StatementDetailViewController: UIActivityItemSource {
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return STATEMENTDETAIL
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController,
                                itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        
        return FileManagerPersistence.shared.getFileURL(fileName: statementDetailViewModel.sharedName)
    }
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        
        let urlImage = FileManagerPersistence.shared.getFileURL(fileName: statementDetailViewModel.sharedName)
        let linkMetaData = LPLinkMetadata()
        linkMetaData.title = APPNAME
        linkMetaData.originalURL = urlImage
        linkMetaData.imageProvider = NSItemProvider.init(contentsOf: urlImage)
        linkMetaData.iconProvider = NSItemProvider.init(contentsOf: urlImage)
        
        return linkMetaData
    }
}

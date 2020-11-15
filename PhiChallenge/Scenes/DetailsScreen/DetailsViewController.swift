//
//  DetailsViewController.swift
//  PhiChallenge
//
//  Created by Felipe Wilke on 13/11/20.
//

import UIKit

final class DetailsViewController: UIViewController {
    //MARK: - Properties
    
    private let contentViewToShare: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.alwaysBounceVertical = true

        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
    
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blackHex
        label.textAlignment = .center
        label.font = UIFont(name: Fonts.arialBold, size: 17)
        label.text = Details.title
        
        return label
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGrayHex
        
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.alignment = .leading
        
        return stackView
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setTitle(ShareButton.title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .cyanHex
        button.titleLabel?.font = UIFont(name: Fonts.arialMT, size: 16)
        
        return button
    }()
    
    private var transferTypeView = ReceiptReusableView()
    private var amountView = ReceiptReusableView()
    private var receiverView = ReceiptReusableView()
    private var bankNameView = ReceiptReusableView()
    private var createdAtView = ReceiptReusableView()
    private var authenticationView = ReceiptReusableView()
    
    private let presenter: DetailsPresenter
    
    //MARK: - Initalization
    
    init(presenter: DetailsPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
        
        presenter.view = self
    }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupViewConfiguration()
        setup()
        actions()
        presenter.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    private func setup() {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    //MARK: - Actions
    
    private func actions() {
        shareButton.addTarget(self, action: #selector(shareDidTap), for: .touchUpInside)
    }
    
    @objc func shareDidTap() {
       
        let viewToshare = contentViewToShare.getImage()
        let activityViewController = UIActivityViewController(activityItems: [viewToshare], applicationActivities: nil)
        present(activityViewController, animated: true)
    }
    
}
//MARK: - DetailsScreenView Interface Implementation

extension DetailsViewController: DetailsScreenView {
    
    func showLoader() {
        Loader.show(in: self)
    }
    
    func hideLoader() {
        Loader.hide()
    }
    
    func showError(message: String) {
        let alertAction = UIAlertAction(title: AlertAction.title, style: .default, handler: { [weak self] handler -> Void in
            self?.presenter.tryAgain()
        })
        showAlert(message: message, alertAction: alertAction)
    }
    
    func setAmount(with text: String) {
        DispatchQueue.main.async  { [weak self] in
            self?.amountView = ReceiptReusableView(title: DetailsViewHeaders.value, text: text, font: Fonts.KohinoorBanglaRegular)
            self?.stackView.addArrangedSubview(self?.amountView ?? UIView())
        }
    }
    
    func setReceiver(with text: String) {
        DispatchQueue.main.async  { [weak self] in
            self?.receiverView = ReceiptReusableView(title: DetailsViewHeaders.receiver, text: text)
            self?.stackView.addArrangedSubview(self?.receiverView ?? UIView())
        }
    }
    
    func setDescription(with text: String) {
        DispatchQueue.main.async  { [weak self] in
            self?.transferTypeView = ReceiptReusableView(title: DetailsViewHeaders.transferType, text: text)
            self?.stackView.addArrangedSubview(self?.transferTypeView ?? UIView())
        }
    }
    
    func setAuthentication(with text: String) {
        DispatchQueue.main.async  { [weak self] in
            self?.authenticationView = ReceiptReusableView(title: DetailsViewHeaders.authentication, text: text)
            self?.stackView.addArrangedSubview(self?.authenticationView ?? UIView())
        }
    }
    
    func setCreatedAt(with text: String) {
        DispatchQueue.main.async  { [weak self] in
            self?.createdAtView = ReceiptReusableView(title: DetailsViewHeaders.dateHour, text: text)
            self?.stackView.addArrangedSubview(self?.createdAtView ?? UIView())
        }
    }
    
    func setBankName(with text: String) {
        if text != "" {
            DispatchQueue.main.async  { [weak self] in
                self?.bankNameView = ReceiptReusableView(title: DetailsViewHeaders.bankName, text: text)
                self?.stackView.addArrangedSubview(self?.bankNameView ?? UIView())
            }
        }
    }
}


extension DetailsViewController: ViewConfiguration {
    
    func setupConstraints() {
        
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shareButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            shareButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            shareButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            shareButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        contentViewToShare.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentViewToShare.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentViewToShare.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentViewToShare.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentViewToShare.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: 20)
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            lineView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            lineView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            lineView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 30),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: -30)
        ])
    
        
    }
    
    func buildViewHierarchy() {
        view.addSubview(shareButton)
        view.addSubview(contentViewToShare)
        view.addSubview(scrollView)
        
        contentView.addSubview(stackView)
        scrollView.addSubview(contentView)
        
        contentViewToShare.addSubview(titleLabel)
        contentViewToShare.addSubview(lineView)
        contentViewToShare.addSubview(scrollView)
   
    }
    
}



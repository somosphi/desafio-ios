//
//  StatementDetailViewController.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 31/12/20.
//

import UIKit

class StatementDetailViewController: LoadingViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var topTitleLabel: MediumBoldLabel!
    @IBOutlet weak var movementTypeTitle: MediumSemiboldLabel!
    @IBOutlet weak var movementTypeValue: BaseLabel!
    @IBOutlet weak var valueTitle: MediumSemiboldLabel!
    @IBOutlet weak var valueLabel: BaseLabel!
    @IBOutlet weak var fromTitle: MediumSemiboldLabel!
    @IBOutlet weak var fromValueLabel: BaseLabel!
    @IBOutlet weak var bankNameTitle: MediumSemiboldLabel!
    @IBOutlet weak var bankNameValueLabel: BaseLabel!
    @IBOutlet weak var dateTitle: MediumSemiboldLabel!
    @IBOutlet weak var dateValueLabel: BaseLabel!
    @IBOutlet weak var autenticationTitle: MediumSemiboldLabel!
    @IBOutlet weak var autenticationValueLabel: BaseLabel!
    @IBOutlet weak var shareButton: UIButton!
    
    // MARK: - Variables
    
    var viewModel: StatementDetailViewModel?
    var exportManager = ExportManager(pdfCreator: ReceiptCreator())
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.getStatementDetail()
        showLoadingPopup()
    }
    
    // MARK: Initialization

    init(statementId: String, bankName: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        viewModel = StatementDetailViewModel(delegate: self, statementId: statementId)
        
        if let bankName = bankName {
            viewModel?.bankName = bankName
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setups
    
    func setupTexts(){
        topTitleLabel.text = StringConstants.receiptTitle
        movementTypeTitle.text = StringConstants.movementTypeTitle
        valueTitle.text = StringConstants.valueTitle
        fromTitle.text = StringConstants.fromTitle
        bankNameTitle.text = StringConstants.bankNameTitle
        dateTitle.text = StringConstants.dateTitle
        autenticationTitle.text = StringConstants.autenticationTitle
        shareButton.setTitle(StringConstants.shareButtonTitle, for: .normal)
    }
    
    // MARK: - Actions
    
    @IBAction func shareButtonTouched(_ sender: Any) {
        guard let statementDetail = viewModel?.statementDetail else {
            return
        }
        
        let result = exportManager.getImage(exportValue: statementDetail)
        
        switch result {
        case .success(let image):
            self.presentShareActivity(with: image)
        case .failure(let error):
            self.present(message: error.localizedDescription)
        }
        
    }
}

// MARK: - Statement Detail ViewModel Delegate

extension StatementDetailViewController: StatementDetailViewModelDelegate {
    func didGetStatementDetail(statementDetail: StatementDetail) {
        DispatchQueue.main.async {
            self.hideLoadingPopup()
            self.setupTexts()
            self.movementTypeValue.text = statementDetail.description
            self.valueLabel.text = statementDetail.getCorrectlyAmount().getReaisValue()
            self.fromValueLabel.text = statementDetail.getCorrectlyFromString()
            self.bankNameValueLabel.text = self.viewModel?.bankName
            self.dateValueLabel.text = statementDetail.createdAt?.getCompleteFormat()
            self.autenticationValueLabel.text = statementDetail.authentication
        }
    }
    
    func failed(message: String) {
        self.hideLoadingPopup()
        self.present(message: message)
    }
}

//
//  MyStatementDetailViewController.swift
//  DesafioIOS
//
//

import UIKit
import Combine

class MyStatementDetailViewController: UIViewController {
    
    // MARK: - View
    
    private var myStatementDetailView : MyStatementDetailView {
        view as! MyStatementDetailView
    }
    
    override func loadView() {
        view = MyStatementDetailView()
    }
    
    // MARK: Model
    private let statementDetailViewModel : MyStatementDetailViewModel
    private var modelItems = [MyStatementDetailItem](){
        didSet{
            statementImageToShare = myStatementDetailView.createStatementImage()
        }
    }
    private var statementImageToShare : UIImage?
   
    // MARK: Model and View Observers
    private var modelItemsObserver : AnyCancellable!
    private var shareButtonPressedObserver : AnyCancellable!
    
   
    // MARK: Initialization
    
    init(viewModel : MyStatementDetailViewModel){
        self.statementDetailViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewDelegates()
        setupObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchDataFromModel() 
    }
    
    // MARK: Setup functions
    private func setupViewDelegates(){
        myStatementDetailView.tableViewDelegate = self
        myStatementDetailView.tableViewDataSource = self
    }
    
    private func setupObservers(){
        modelItemsObserver = self.statementDetailViewModel.itemDetailObservable.sink{[weak self] result in
            DispatchQueue.main.async {
                defer {
                    self?.myStatementDetailView.stopLoadingAnimation()
                }
                switch(result){
                    case .success(let myStatementDetail):
                        self?.modelItems = myStatementDetail.itemsAsList()
                    case .failure(let error):
                        self?.showAlertError(errorMessage: error.shortDescription)
                }
            }
        }
    
        shareButtonPressedObserver = myStatementDetailView.shareButtonPressedObservable.sink{[weak self] in
            DispatchQueue.main.async {
                self?.shareStatementImage()
            }
        }
    }
    
    private func fetchDataFromModel(){
        myStatementDetailView.startLoadingAnimation()
        statementDetailViewModel.fetchStatementDetail()
    }
    
    // MARK: Auxiliar functions
    
    private func shareStatementImage(){
        guard let imageToShare = statementImageToShare else {
            self.showAlertError(errorMessage: "Erro ao gerar imagem do comprovante")
            return
        }
        let ac = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
        present(ac, animated: true)
    }
    
    private func showAlertError(errorMessage : String){
        let alert = createErrorAlert(errorMessage: errorMessage)
        present(alert, animated: true, completion: nil)
    }
    
    private func createErrorAlert(errorMessage : String)  -> UIAlertController{
        let alert = UIAlertController(title: "Desculpe, ocorreu um problema", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        return alert
    }

}

extension MyStatementDetailViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyStatementDetailTableViewCell.identifier, for: indexPath) as? MyStatementDetailTableViewCell else { return UITableViewCell()}
        cell.updateWith(model: modelItems[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel.createDynamicFontLabel(fontStyle: .title2)
        label.text = "Comprovante"
        label.textAlignment = .center
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}

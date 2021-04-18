//
//  MyStatementViewController.swift
//  DesafioIOS
//
//

import UIKit


import Combine
class MyStatementViewController: UIViewController {
    
    // MARK: - View Controllers Coordinator
    weak var coordinator : MainCoordinator?
   
    
    // MARK: - View
    
    private var myStatementView : MyStatementView { return view as! MyStatementView }
    override func loadView() {
        view = MyStatementView()
    }
    
    // MARK: - Model
    
    private let viewModel : MyStatementViewModel
    private var statementItems = [MyStatementItem](){
        didSet{
            myStatementView.reloadTableViewData()
        }
    }
    // MARK: - ViewModel and View Observers
    private var myBalanceObserver : AnyCancellable!
    private var statementItemsObserver : AnyCancellable!
    private var showBalanceSettingsObserver : AnyCancellable!
    private var isLoadingStatementItemsObserver : AnyCancellable!
    private var showBallanceButtonPressedObserver : AnyCancellable!
    
    // MARK: - Initialization
    init(viewModel : MyStatementViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewDelegates()
        setupObservers()
        fetchFirstDataFromViewModel()
    }
    
    // MARK: - Setup functions
    
    private func setupViewDelegates(){
        myStatementView.statementsTableViewDelegate = self
        myStatementView.statementsTableViewDataSource = self
    }
    
    private func setupObservers(){
        myBalanceObserver = viewModel.myBalanceObservable.sink{[weak self] result in
            DispatchQueue.main.async {
                self?.myStatementView.updateBalance(balanceResult: result)
            }
        }
        
        statementItemsObserver = viewModel.statementItemsObservable.sink{[weak self] result in
            DispatchQueue.main.async {
                defer {
                    self?.myStatementView.stopTableViewLoadingAnimation()
                }
                
                switch(result){
                    case .success(let statementItems):
                        self?.statementItems = statementItems
                        
                    case .failure(let error):
                        self?.showFetchStatementsAlertError(error: error)
                }
            }
            
        }

        isLoadingStatementItemsObserver = viewModel.isLoadingStatementsItemsObservable.sink{[weak self] isLoading in
            DispatchQueue.main.async {
                if !isLoading{
                    self?.myStatementView.stopFooterSpinnerLoadingAnimation()
                }
            }
        }
        
        showBalanceSettingsObserver = viewModel.showBalanceSettingsObservable.sink{[weak self] showBalance in
            DispatchQueue.main.async {
                self?.myStatementView.showBalanceToUser(showBalance)
            }
        }
        
        showBallanceButtonPressedObserver = myStatementView.showBalanceButtonPressedObservable.sink{[weak self] in
                self?.viewModel.showBalanceButtonWasPressed()
        }
    }
    
    private func fetchFirstDataFromViewModel(){
        myStatementView.startTableViewLoadingAnimation()
        viewModel.fetchBalance()
        viewModel.fetchStatements()
    }
    
    // MARK: - Auxiliar functions
    private func showFetchStatementsAlertError(error : StatementLoadErrorViewModel){
        let alertError = createErrorAlert(error: error, tryAgainAction: {[weak self] action in
            self?.fetchFirstDataFromViewModel()
        })
        self.present(alertError, animated: true, completion: nil)
    }
    
    private func createErrorAlert(error : StatementLoadErrorViewModel, tryAgainAction: @escaping(UIAlertAction) -> Void) -> UIAlertController{
        let alert = UIAlertController(title: "Desculpe, ocorreu um problema", message: error.shortDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again?", style: .default, handler: tryAgainAction))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        return alert
    }
}

extension MyStatementViewController : UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = MyStatementTableViewHeader()
        header.updateWith(title: "Suas movimentações")
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statementItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyStatementItemTableViewCell.identifier, for: indexPath) as? MyStatementItemTableViewCell else { return  UITableViewCell()}
        cell.updateWith(statementItem: statementItems[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollViewWasScrolledToBottom(scrollView)){
            myStatementView.startFooterSpinnerLoadingAnimation()
            viewModel.fetchStatements()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator?.showStatementDetail(id: statementItems[indexPath.row].id)
    }
    
    private func scrollViewWasScrolledToBottom(_ scrollView: UIScrollView) -> Bool{
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        return offsetY > contentHeight - scrollView.frame.size.height
    }
    
    
    
}




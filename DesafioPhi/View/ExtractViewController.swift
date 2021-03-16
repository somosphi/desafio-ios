//
//  ViewController.swift
//  DesafioPhi
//
//  Created by Lucas Siqueira on 11/03/21.
//

import UIKit

class ExtractViewController: UIViewController {
    //MARK: Views
    
    /// Botão que define a visibilidade do saldo
    @IBOutlet weak var eyeButton: UIButton!
    /// Label com o texto do saldo
    @IBOutlet weak var balanceLabel: UILabel!
    /// Table View com as movimentações financeiras
    @IBOutlet weak var tableView: UITableView!
    /// Indicador de carregamento
    let activityIndicator = UIActivityIndicatorView()
    
    //MARK: Instance properties
    
    /// View Model que configura o saldo para a view
    let balanceViewModel = BalanceViewModel(balance: BalanceModel())
    /// View Model que configura os dados das transações para a view
    let extractViewModel = ExtractViewModel(extracts: [Item]())
    
    //MARK: Life Circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationControllerSetup()
    }
    
    //MARK: Functions
    
    /**
     Método acionado ao tocar no botão do olho
     */
    @IBAction func eyeButtonAction(_ sender: Any) {
        balanceViewModel.hiddenAmount()
    }
    
    //MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            guard let destinationView = segue.destination as? ReceiptViewController else {return}
            destinationView.receiptViewModel.id = self.extractViewModel.returnIdTransaction(index: selectedRow)
        }
    }

}

//MARK: Protocol Setup

extension ExtractViewController: ViewControllerProtocol{
    func setup(){
        DataPersistence.shared.requestForLocation()
        tableViewSetup()
        closureSetup()
        getContentSetup()
    }
    
    func closureSetup()  {
        balanceViewModel.reloadData = { [weak self] ()  in
            DispatchQueue.main.async {
                self?.balanceLabel.text = self?.balanceViewModel.amount
                self?.eyeButton.setImage(self?.balanceViewModel.eyeImage, for: .normal)
            }
        }
        balanceViewModel.errorMessage = { (error)  in
            DispatchQueue.main.async {
                print("Error: \(error)")
            }
        }
        extractViewModel.reloadData = { [weak self] ()  in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        extractViewModel.errorMessage = { (error)  in
            DispatchQueue.main.async {
                print("Error: \(error)")
            }
        }
    }
    
    func getContentSetup(){
        balanceViewModel.reloadData()
        balanceViewModel.getContentData()
        extractViewModel.getContentData()
    }
    
    func navigationControllerSetup(){
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}


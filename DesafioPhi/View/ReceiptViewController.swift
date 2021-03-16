//
//  ReceiptViewController.swift
//  DesafioPhi
//
//  Created by Lucas Siqueira on 14/03/21.
//

import Foundation
import UIKit

/**
 Classe do comprovante
 */
class ReceiptViewController: UIViewController {
    //MARK: Views
    
    /// Tipo de transação
    @IBOutlet weak var typeTransaction: UILabel!
    /// Valor da transação
    @IBOutlet weak var amount: UILabel!
    /// Favorecido (quem recebeu a transação)
    @IBOutlet weak var favored: UILabel!
    /// Banco que efetuou ou recebeu a transação
    @IBOutlet weak var bank: UILabel!
    /// Data da transação
    @IBOutlet weak var date: UILabel!
    /// Código de autenticação
    @IBOutlet weak var authentication: UILabel!
    /// Botão de compartilhamento
    @IBOutlet weak var shareButton: UIButton!
    /// Indicador de carregamento
    let activityIndicator = UIActivityIndicatorView()
    
    //MARK: Instance properties
    
    /// View Model que configura os dados do comprovante para a view
    let receiptViewModel = ReceiptViewModel(receipt: ReceiptModel())
    /// instância da classe utilizada para exibir mensagens na view controller
    var sharePresenter: SharePresenterProtocol?
    
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
     Método que prepara os itens para compartilhamento
     */
    @IBAction func prepareShare(_ sender: Any) {
        hideItems()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: share)
    }
    
    /**
     Método que captura a imagem e aciona a aba de compartilhamento
     */
    func share(){
        sharePresenter?.presentShare(on: self, completion: hideItems)
    }
    
    /**
     Método que oculta ou retorna os itens ocultados ao seu estado natural
     */
    func hideItems(){
        shareButton.isHidden = !shareButton.isHidden
        if shareButton.isHidden{
            navigationController?.navigationBar.tintColor = .white
        }else{
            navigationController?.navigationBar.tintColor = UIColor(named: "BlackMainColor")
        }
    }
}

//MARK: Protocol Setup

extension ReceiptViewController: ViewControllerProtocol{
    func setup(){
        sharePresenter = SharePresenter()
        closureSetup()
        getContentSetup()
    }
    
    func closureSetup()  {
        receiptViewModel.reloadData = { [weak self] ()  in
            DispatchQueue.main.async {
                self?.typeTransaction.text = self?.receiptViewModel.typeTransaction
                self?.amount.text = self?.receiptViewModel.amount
                self?.favored.text = self?.receiptViewModel.favored
                self?.bank.text = self?.receiptViewModel.bank
                self?.date.text = self?.receiptViewModel.date
                self?.authentication.text = self?.receiptViewModel.authentication
            }
        }
        receiptViewModel.errorMessage = { (error)  in
            DispatchQueue.main.async {
                print("Error: \(error)")
            }
        }
    }
    
    func getContentSetup(){
        receiptViewModel.getContentData()
    }
    
    func navigationControllerSetup(){
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
}

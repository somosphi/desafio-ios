//
//  ViewController.swift
//  desafio-ios
//
//  Created by Alexandre Scheer Bing on 05/12/20.
//

import UIKit
import RxSwift

class StatementViewController: UIViewController {
    
    @IBOutlet weak var showExtractButton: UIButton!
    @IBOutlet weak var extractLabel: UILabel!
    
    @IBOutlet weak var transferStatementTableView: UITableView!
    
    let disposeBag = DisposeBag()
    private var viewModel: StatementViewModel!
    var coordinator: MainCoordinator?
    var showExtract: Bool = false

    static func instantiate(with viewModel: StatementViewModel) -> StatementViewController {
        let storyboard = UIStoryboard(name: "StatementView", bundle: .main)
        guard let viewController = storyboard.instantiateInitialViewController() as? StatementViewController else { return StatementViewController()}
        viewController.viewModel = viewModel
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func toggleExtractView(_ sender: Any) {
    }
    


}


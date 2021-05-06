//
//  ViewController.swift
//  Desafio-iOS
//
//  Created by Alex Freitas on 28/04/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var amountLabel: UILabel!

    @IBAction func apiTest(_ sender: Any) {
        let service = QueryService()

        service.getAmount { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let amount):
                DispatchQueue.main.async {
                    self.amountLabel.text = String(amount)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

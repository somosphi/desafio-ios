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

        service.getAmount { amountInfo in
            DispatchQueue.main.async {
                self.amountLabel.text = String(amountInfo)
            }
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

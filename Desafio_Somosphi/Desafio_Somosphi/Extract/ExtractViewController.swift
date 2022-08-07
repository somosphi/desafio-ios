//
//  ViewController.swift
//  Desafio_Somosphi
//
//  Created by Suh on 02/08/22.
//

import UIKit

class ExtractViewController: UIViewController {

    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    weak var coordinator: ExtractCoordinator?

    var movements: [Extract] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
        movements = mockExtract()
    }

}

extension ExtractViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movements.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell", for: indexPath
        ) as? ExtractTableViewCell else {
            fatalError()
        }
        let extract = movements[indexPath.row]
        cell.prepare(model: extract)
        return cell
    }

}

private func mockExtract() -> [Extract] {
    return [
        .fixture(),
        .fixture(),
        .fixture(),
        .fixture()
    ]
}

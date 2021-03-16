//
//  TableView.swift
//  DesafioPhi
//
//  Created by Lucas Siqueira on 14/03/21.
//

import Foundation
import UIKit

extension ExtractViewController: UITableViewDelegate, UITableViewDataSource{
    //MARK: Table View Setup
    
    /**
     Método que configura o delegate e data source da table view
     */
    func tableViewSetup()  {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundView = activityIndicator
        activityIndicator.startAnimating()
    }
    
    //MARK: Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return extractViewModel.countItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TransactionsViewCell
        cell.typeTransaction.text = extractViewModel.returnTypeTransaction(index: indexPath.row)
        cell.favored.text = extractViewModel.returnFavored(index: indexPath.row)
        cell.date.text = extractViewModel.returnDate(index: indexPath.row)
        cell.pix.isHidden = !extractViewModel.returnPix(index: indexPath.row)
        cell.amount.text = extractViewModel.returnAmount(index: indexPath.row)
        cell.backgroundColor = extractViewModel.returnPix(index: indexPath.row) == true ? UIColor(named: "WhiteMainColor") : UIColor.white
        cell.lineConstraint.constant = indexPath.row == 0 ? 20 : 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == extractViewModel.countItems - 5 {
            extractViewModel.getContentData()
        }
    }
}

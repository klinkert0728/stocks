//
//  StockPreviewTableViewController.swift
//  Stocks
//
//  Created by Daniel Klinkert Houfer on 4/21/17.
//  Copyright © 2017 Daniel Klinkert Houfer. All rights reserved.
//

import UIKit
import SVProgressHUD
import RealmSwift

class StockPreviewTableViewController: BaseTableViewController {
    
    var stocks = [Stock]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStocks()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func registerCells() {
        super.registerCells()
        tableView.register(UINib(nibName:"StockPreviewTableViewCell",bundle:nil), forCellReuseIdentifier: "StockPreviewTableViewCell")
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        title   = "Stocks"
        tableView.rowHeight             = UITableViewAutomaticDimension
        tableView.estimatedRowHeight    = 50
        tableView.backgroundColor       = UIColor(red:0.36, green:0.59, blue:1.00, alpha:0.9)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if stocks.count == 0 {
            return 1
        }
        
        
        
        return stocks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if stocks.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as! EmptyTableViewCell
            
            return cell
            
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "StockPreviewTableViewCell", for: indexPath) as! StockPreviewTableViewCell
            
            
            cell.setupCell(stock: stocks[indexPath.row])
            // Configure the cell...
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let refresh = UITableViewRowAction(style: .normal, title: "Refresh") { action, index in
            SVProgressHUD.show(withStatus: "Refreshing")
            Stock.addStock(endPoint: DKHEndPoint.search(symbol: self.stocks[index.row].symbol), closure: { (stock, error) in
                guard let _ = stock else {
                    return
                }
                
                self.getStocks()
            })
        }
        refresh.backgroundColor = .lightGray
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { action, index in
            Realm.update(updateClosure: { (realm) in
                realm.delete(self.stocks[index.row])
            })
            self.getStocks()
        }
        
        return [delete, refresh]
    }
    
    
    private func getStocks() {
        Stock.getStocksFromDB { (stocks) in
            self.stocks = stocks
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchSegue" {
            let nextVc = segue.destination as? SearchViewController
            
            nextVc?.selectedStockClousure = { stockPreview in
                let _ = self.navigationController?.popViewController(animated: true)
                Stock.addStock(endPoint: DKHEndPoint.search(symbol: stockPreview.symbol), closure: { (stock, error) in
                    guard let _ = stock else {
                        SVProgressHUD.showInfo(withStatus: error?.localizedDescription)
                        return
                    }
                    
                    self.getStocks()
                })
            }
        }
        
        if segue.identifier == "filterSegue" {
            let nextVc = segue.destination as? FilterViewController
            
            nextVc?.modalPresentationStyle = UIModalPresentationStyle.popover
            nextVc?.popoverPresentationController!.delegate = self
            
            let popover = nextVc!.popoverPresentationController!
          
            popover.delegate    = self
            popover.sourceView  = self.view
            popover.sourceRect  = CGRect(x:100,y:100,width:0,height:0)
            
           
        }
    }
    
    @IBAction func addStock(_ sender: Any) {
        performSegue(withIdentifier: "searchSegue", sender: nil)
    }
    
    
    @IBAction func refeshFilter(_ sender: Any) {
    }
    
    @IBAction func filter(_ sender: Any) {
        
        performSegue(withIdentifier: "filterSegue", sender: nil)
    }
    
    
}


extension StockPreviewTableViewController:UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    
}

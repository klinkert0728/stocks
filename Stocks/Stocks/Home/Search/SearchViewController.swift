//
//  SearchViewController.swift
//  Stocks
//
//  Created by Daniel Klinkert Houfer on 4/23/17.
//  Copyright © 2017 Daniel Klinkert Houfer. All rights reserved.
//

import UIKit
import SVProgressHUD

class SearchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    var stocksPreviewArray   = [StockPreview]()
    
    var selectedStockClousure:((_ stock:StockPreview)->())?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource                = self
        tableView.delegate                  = self
        searchBar.delegate                  = self
        title                               = "Stocks"
        tableView.tableFooterView           = UIView()
        tableView.tableHeaderView           = nil
        tableView.backgroundColor           = UIColor(red:0.36, green:0.59, blue:1.00, alpha:0.9)
        tableView.register(UINib(nibName:"SearchCellTableViewCell",bundle:nil), forCellReuseIdentifier: "Cell")
        tableView.rowHeight                 = UITableViewAutomaticDimension
        tableView.estimatedRowHeight        = 44
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocksPreviewArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchCellTableViewCell
        
        
        cell.setupCell(preview: stocksPreviewArray[indexPath.row])
        
        cell.selectedClousure = {
            
            self.selectedStockClousure?(self.stocksPreviewArray[indexPath.row])
        }
        
        
        
        return cell
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.characters.count > 3 {
            StockPreview.addStockPreview(endPoint: DKHEndPoint.lookup(name: searchText)) { (stocksPreview, error) in
                
                guard let stocks = stocksPreview else {
                    SVProgressHUD.showInfo(withStatus: error?.localizedDescription)
                    return
                }
                self.stocksPreviewArray = stocks
                
                self.tableView.reloadData()
                
            }
        }
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

//
//  StockPreviewTableViewCell.swift
//  Stocks
//
//  Created by Daniel Klinkert Houfer on 4/21/17.
//  Copyright © 2017 Daniel Klinkert Houfer. All rights reserved.
//

import UIKit

class StockPreviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var changePercent: UILabel!
    @IBOutlet weak var change: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupCell(stock:Stock) {
        
        name.text           = stock.name
        change.text         = "\(stock.changePercent) %"
        
        if stock.change > 0 {
            changePercent.text      = String(format: "+ %.2f", stock.change)
            changePercent.textColor = UIColor(red:0.60, green:1.00, blue:0.19, alpha:1.0)
        }else{
            changePercent.text      = String(format: "%.2f", stock.change)
            changePercent.textColor = UIColor.red
        }
        
    }
    
}

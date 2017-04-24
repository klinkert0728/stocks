//
//  SearchCellTableViewCell.swift
//  Stocks
//
//  Created by Daniel Klinkert Houfer on 4/23/17.
//  Copyright © 2017 Daniel Klinkert Houfer. All rights reserved.
//

import UIKit

class SearchCellTableViewCell: UITableViewCell {

    var selectedClousure:(()->())?
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(preview:StockPreview) {
       
        name.text = preview.name
        
    }
    @IBAction func buttonAction(_ sender: Any) {
        
        selectedClousure?()
    }
    
}

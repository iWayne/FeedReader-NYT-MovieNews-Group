//
//  CustomTableCell.swift
//  PolyNewsReader
//
//  Created by Elaine Chang on 4/18/15.
//  Copyright (c) 2015 Spark451. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
         
    @IBOutlet weak var titleimage: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
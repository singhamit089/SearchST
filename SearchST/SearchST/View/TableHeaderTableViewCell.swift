//
//  TableHeaderTableViewCell.swift
//  SearchST
//
//  Created by Amit  Singh on 28/04/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import UIKit

class TableHeaderTableViewCell: UITableViewCell, LoadableFromNib {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

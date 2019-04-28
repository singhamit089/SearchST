//
//  ItemTableViewCell.swift
//  SearchST
//
//  Created by Amit  Singh on 28/04/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell, LoadableFromNib {

    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var itemTitleLabel: UILabel!
    
    @IBOutlet weak var authorsLabel: UILabel!
    
    @IBOutlet weak var narratorsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(title:String?,authors:[Author]?,narators:[Narrator]?) {
        self.itemTitleLabel.text = title ?? ""
        
        var authorsString = "by "
        var naratorString = "with "
        
        _ =  authors?.map({ author in
            authorsString += " \(author.name ?? ""),"
        })
        
        _ = narators?.map({ narrator in
            naratorString += " \(narrator.name ?? ""),"
        })
        
        self.authorsLabel.text = "\(authorsString.dropLast())"
        self.narratorsLabel.text = "\(naratorString.dropLast())"
    }
    
}

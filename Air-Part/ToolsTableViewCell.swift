//
//  ToolsTableViewCell.swift
//  Air-Part
//
//  Created by Андрей Бабий on 19.08.17.
//  Copyright © 2017 Андрей Бабий. All rights reserved.
//

import UIKit

class ToolsTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var imageIcon: UIImageView!
    
    @IBOutlet weak var lblMenuName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

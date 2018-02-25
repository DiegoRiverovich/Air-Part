//
//  UserCell.swift
//  Air-Part
//
//  Created by Андрей Бабий on 01.09.17.
//  Copyright © 2017 Андрей Бабий. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
//    var message: Message? {
//        didSet {
//            
//        }
//    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

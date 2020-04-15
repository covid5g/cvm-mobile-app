//
//  SettingCell.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
   
    @IBOutlet weak var settingCell: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }

    func set(_ setting: String) {
        settingCell.text = setting
    }
}


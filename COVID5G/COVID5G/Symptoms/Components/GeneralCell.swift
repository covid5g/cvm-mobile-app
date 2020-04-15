//
//  GeneralCell.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import UIKit

class GeneralCell: UITableViewCell {
    
    @IBOutlet weak var generalLabel: UILabel!
    @IBOutlet weak var generalSwitch: UISwitch!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func set(_ general: General) {
        generalLabel.text = general.question
        generalSwitch.setOn(false, animated: false)
    }
    
}

//
//  PreExistingCell.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import UIKit

class PreExistingCell: UITableViewCell {
   
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var conditionSwitch: UISwitch!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }

    func set(_ condition: PreExisting) {
        conditionLabel.text = condition.question
        conditionSwitch.setOn(false, animated: false)
    }
}

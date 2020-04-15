//
//  SymptomCell.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import UIKit

class SymptomCell: UITableViewCell {
    
    @IBOutlet weak var symptomLabel: UILabel!
    @IBOutlet weak var symptomSwitch: UISwitch!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func set(_ symptom: Symptom) {
        symptomLabel.text = symptom.displayName
        symptomSwitch.setOn(symptom.value, animated: false)
    }
    
}

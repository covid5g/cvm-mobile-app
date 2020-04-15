//
//  RecordedSymptomCell.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import UIKit

class RecordedSymptomCell: UITableViewCell {

    
    @IBOutlet weak var symptonName: UILabel!
    @IBOutlet weak var symptomDate: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func set(_ symptom: RecordedSymptom) {
        symptonName.text = symptom.displayName
        symptomDate.text = symptom.date
    }
    
}

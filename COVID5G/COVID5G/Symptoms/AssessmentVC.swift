//
//  AssessmentVC.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class AssessmentVC: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var recordedSymptomsTableView: UITableView!
    
    var symptoms: BehaviorRelay<[RecordedSymptom]> = BehaviorRelay(value: [])
    var disposeBag: DisposeBag = DisposeBag()
    
    let viewModel = AssessmentVM()
    let preferences = UserDefaults.standard
    
    override func viewDidAppear(_ animated: Bool) {
        getData()
        computeScore()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        startSubscriptions()
        recordedSymptomsTableView.register(UINib(nibName: "RecordedSymptomCell", bundle: Bundle.main), forCellReuseIdentifier: "RecordedSymptomCell")
        bindData()
    }
    
}

extension AssessmentVC {
    func startSubscriptions() {

    }
    
    func restartSubscriptions() {
        disposeSubscriptions()
        startSubscriptions()
    }
    
    func disposeSubscriptions() {
        disposeBag = DisposeBag()
    }
    
}

extension AssessmentVC {
    
    func getData() {
        SymptomsManager.shared.getRecordedSymptoms { symptoms in
            self.symptoms.accept(symptoms)
            let sortedSymptoms = self.symptoms.value.sorted(by: { $0.date > $1.date })
            self.symptoms.accept(sortedSymptoms)
        }
    }
    
    func bindData() {
        symptoms.bind(to: recordedSymptomsTableView.rx.items(cellIdentifier: "RecordedSymptomCell",
                                                             cellType: RecordedSymptomCell.self)) { _, element, cell in
                                                                cell.set(element)}.disposed(by: disposeBag)
        
    }
    
    func computeScore() {
        let symptomScore = preferences.integer(forKey: "symptomScore")
        let generalScore = preferences.integer(forKey: "generalScore")
        let preExistingScore = preferences.integer(forKey: "preExistingScore")
        
        if symptomScore == 0 && generalScore == 0 && preExistingScore == 0 {
            textView.text = viewModel.managementQuestion.value[5].recommendation
        }
        
        if symptomScore == 0 && generalScore > 0 && preExistingScore == 0 {
            textView.text = viewModel.managementQuestion.value[4].recommendation
        }
        
        if symptomScore > 0 && generalScore > 0 && preExistingScore == 0 {
            textView.text = viewModel.managementQuestion.value[3].recommendation
        }
        
        if symptomScore > 0 && generalScore == 0 && preExistingScore == 0 {
            textView.text = viewModel.managementQuestion.value[3].recommendation
        }
        
        if symptomScore > 0 && generalScore == 0 && preExistingScore > 0 {
            textView.text = viewModel.managementQuestion.value[2].recommendation
        }
        
        if symptomScore > 0 && generalScore > 0 && preExistingScore > 0 {
            textView.text = viewModel.managementQuestion.value[2].recommendation
        }
        
        if (symptomScore >= 20 && symptomScore < 30) && generalScore > 0 && preExistingScore > 0 {
            textView.text = viewModel.managementQuestion.value[1].recommendation
        }
        
        if symptomScore >= 30 && generalScore > 0 && preExistingScore == 0 {
            textView.text = viewModel.managementQuestion.value[1].recommendation
        }
        
        if symptomScore >= 30 && generalScore == 0 && preExistingScore > 0 {
            textView.text = viewModel.managementQuestion.value[1].recommendation
        }
        
        if symptomScore >= 30 && generalScore > 0 && preExistingScore > 0 {
            textView.text = viewModel.managementQuestion.value[0].recommendation
        }
        
    }
}

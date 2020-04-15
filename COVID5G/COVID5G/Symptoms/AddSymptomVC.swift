//
//  AddSymptomVC.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//


import RxCocoa
import RxSwift
import UIKit

class AddSymptomVC: UIViewController {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var symptomsTableView: UITableView!
    
    let viewModel = SymptomsVM()
    let preferences = UserDefaults.standard
    var set = Set<Symptom>()
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidAppear(_ animated: Bool) {
        set = []
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        startSubscription()
        symptomsTableView.register(UINib(nibName: "SymptomCell", bundle: Bundle.main), forCellReuseIdentifier: "SymptomCell")
        symptomsTableView.rowHeight = 80
        bindData()
    }
    
}

extension AddSymptomVC {
    func startSubscription() {
        addButton.rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                guard let symptomScore = self?.preferences.integer(forKey: "symptomScore") else { return }
                self?.preferences.set(symptomScore + ((self?.set.count)!*10), forKey: "symptomScore")
                self?.set.forEach { symptom in
                    SymptomsManager.shared.postRecordedSymptom(with: symptom)
                }
                
            }).disposed(by: disposeBag)
    }
    
    func restartSubscriptions() {
        disposeSubscriptions()
        startSubscription()
    }
    
    func disposeSubscriptions() {
        disposeBag = DisposeBag()
    }
}

extension AddSymptomVC {
    func bindData() {
        self.viewModel.symptoms.bind(to: symptomsTableView.rx.items(cellIdentifier: "SymptomCell",
                                                                    cellType: SymptomCell.self)) { _, element, cell in
                                                                        cell.set(element)
                                                                        cell.symptomSwitch.rx.isOn.changed
                                                                            .distinctUntilChanged().asObservable()
                                                                            .subscribe(onNext: { [weak self] value in
                                                                                self?.setSymptom(element: element, value: value)
                                                                                
                                                                            }).disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
    }
    
    func setSymptom(element: Symptom, value: Bool) {
        if value {
            self.set.insert(element)
        } else {
            set = set.filter { $0.displayName != element.displayName }
        }
    }
}

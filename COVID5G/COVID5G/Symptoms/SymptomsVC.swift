//
//  SymptomsVC.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class SymptomsVC: UIViewController {

    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var symptomsTableView: UITableView!
    
    
    let viewModel = SymptomsVM()
    var set = Set<Symptom>()
    var symptomScore = 1
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startSubscriptions()
        
        symptomsTableView.register(UINib(nibName: "SymptomCell", bundle: Bundle.main), forCellReuseIdentifier: "SymptomCell")
        symptomsTableView.rowHeight = 80
        bindData()
        
        
    }
}

extension SymptomsVC {
    func startSubscriptions() {
        continueButton.rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                UserDefaults.standard.set((self!.symptomScore*self!.set.count*10), forKey: "symptomScore")
                MainCoordinator.shared.loginUser()
                self?.dismiss(animated: false, completion: nil)
            }).disposed(by: disposeBag)
    }
    
    func restartSubscriptions() {
        disposeSubscriptions()
        startSubscriptions()
    }
    
    func disposeSubscriptions() {
        disposeBag = DisposeBag()
    }
}

extension SymptomsVC {
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


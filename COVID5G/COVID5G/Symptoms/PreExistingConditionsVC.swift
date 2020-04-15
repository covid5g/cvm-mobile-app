//
//  PreExistingConditionsVC.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class PreExistingConditionsVC: UIViewController {
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var preExistingConditionTableView: UITableView!
    
    
    var disposeBag: DisposeBag = DisposeBag()
    let viewModel = PreExistingConditionsVM()
    let preferences = UserDefaults.standard
    var set = Set<PreExisting>()
    var preExistingScore = 1
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startSubscriptions()
        
        preExistingConditionTableView.register(UINib(nibName: "PreExistingCell", bundle: Bundle.main), forCellReuseIdentifier: "PreExistingCell")
        preExistingConditionTableView.rowHeight = 80
        computeScore()
    }
}

extension PreExistingConditionsVC {
    func startSubscriptions() {
        continueButton.rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                UserDefaults.standard.set((self!.preExistingScore*self!.set.count*10), forKey: "preExistingScore")
//                MainCoordinator.shared.onProfile()
                self?.dismiss(animated: true, completion: nil)
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

extension PreExistingConditionsVC {
    
    func bindData(to state: PreExistingCondtionVCState) {
        switch state {
        case .immediate:   viewModel.immediateQuestions.bind(to: preExistingConditionTableView.rx.items(cellIdentifier: "PreExistingCell",
                                                                                                        cellType: PreExistingCell.self)) { _, element, cell in
                                                                                                            cell.set(element)
                                                                                                            cell.conditionSwitch.rx.isOn.changed
                                                                                                                .distinctUntilChanged().asObservable()
                                                                                                                .subscribe(onNext: {[weak self] value in
                                                                                                                    self?.setCondition(element: element, value: value)
                                                                                                                    
                                                                                                                }).disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
        
        preExistingConditionTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.processCellSelect(indexPath: indexPath, and: self!.preExistingConditionTableView, and: self!.viewModel.immediateQuestions)
            }).disposed(by: disposeBag)
            
        case .urgent: viewModel.urgentQuestions.bind(to: preExistingConditionTableView.rx.items(cellIdentifier: "PreExistingCell",
                                                                                                cellType: PreExistingCell.self)) { _, element, cell in
                                                                                                    cell.set(element)
                                                                                                    cell.conditionSwitch.rx.isOn.changed
                                                                                                        .distinctUntilChanged().asObservable()
                                                                                                        .subscribe(onNext: {[weak self] value in
                                                                                                            self?.setCondition(element: element, value: value) }).disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
            
            preExistingConditionTableView.rx.itemSelected
                .subscribe(onNext: { [weak self] indexPath in
                    self?.processCellSelect(indexPath: indexPath, and: self!.preExistingConditionTableView, and: self!.viewModel.urgentQuestions)
                }).disposed(by: disposeBag)
                            
        case .suspect: viewModel.suspectQuestions.bind(to: preExistingConditionTableView.rx.items(cellIdentifier: "PreExistingCell",
                                                                                                  cellType: PreExistingCell.self)) { _, element, cell in
                                                                                                    cell.set(element)
                                                                                                    cell.conditionSwitch.rx.isOn.changed
                                                                                                        .distinctUntilChanged().asObservable()
                                                                                                        .subscribe(onNext: {[weak self] value in
                                                                                                            self?.setCondition(element: element, value: value)
                                                                                                            
                                                                                                        }).disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
            
            preExistingConditionTableView.rx.itemSelected
                .subscribe(onNext: { [weak self] indexPath in
                    self?.processCellSelect(indexPath: indexPath, and: self!.preExistingConditionTableView, and: self!.viewModel.suspectQuestions)
                }).disposed(by: disposeBag)
        }

    }
    
    func processCellSelect(indexPath: IndexPath, and tableview: UITableView, and conditions: BehaviorRelay<[PreExisting]>) {
        guard let cell = tableview.cellForRow(at: indexPath) as? PreExistingCell,
            indexPath.row < conditions.value.count else {
                return
        }
        
        let element = conditions.value[indexPath.row]
        
        let value = !cell.conditionSwitch.isOn
        cell.conditionSwitch.setOn(value, animated: true)
        setCondition(element: element, value: value)
    }
    
    func setCondition(element: PreExisting, value: Bool) {
        if value {
            set.insert(element)
        } else {
            set = set.filter { $0.question != element.question }
        }
    }
    
}

extension PreExistingConditionsVC {
    func computeScore() {
        let symptomScore = preferences.integer(forKey: "symptomScore")
        let generalScore = preferences.integer(forKey: "generalScore")
        
        if symptomScore >= 20 && generalScore >= 10 {
            bindData(to: .immediate)
            return
        }
        
        if symptomScore >= 0 && generalScore >= 10 {
            bindData(to: .urgent)
            return
        }
        
        if symptomScore >= 0 && generalScore >= 0 {
            bindData(to: .suspect)
            return
        }
    }
}

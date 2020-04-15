//
//  PreExistingConditionsVM.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import RxCocoa
import RxSwift
import Foundation

enum PreExistingCondtionVCState {
    case urgent
    case immediate
    case suspect
}

class PreExistingConditionsVM {
    let immediateRepository = ImmediateMedicalLocal.self
    let urgentRepository = UrgentMedicalLocal.self
    let suspectRepository = SuspectCaseLocal.self
   
    var immediateQuestions: BehaviorRelay<[PreExisting]> = BehaviorRelay(value: [])
    var urgentQuestions: BehaviorRelay<[PreExisting]> = BehaviorRelay(value: [])
    var suspectQuestions: BehaviorRelay<[PreExisting]> = BehaviorRelay(value: [])
    var viewControllerState: BehaviorRelay<PreExistingCondtionVCState> = BehaviorRelay(value: .urgent)
    
    var disposeBag = DisposeBag()
    
    init() {
        immediateRepository.get(disposeBag: disposeBag) { [weak self] model, error in
            guard error == nil, let model = model else {
                return
            }
            self?.immediateQuestions.accept(model)
        }
        
        urgentRepository.get(disposeBag: disposeBag) { [weak self] model, error in
            guard error == nil, let model = model else {
                return
            }
            self?.urgentQuestions.accept(model)
        }
        
        suspectRepository.get(disposeBag: disposeBag) { [weak self] model, error in
            guard error == nil, let model = model else {
                return
            }
            self?.suspectQuestions.accept(model)
        }

    }
}


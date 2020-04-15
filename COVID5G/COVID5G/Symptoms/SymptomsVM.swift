//
//  SymptomsVM.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import RxCocoa
import RxSwift
import Foundation

class SymptomsVM {
    let symptomsRepository = SymptomsLocal.self
    
    var symptoms: BehaviorRelay<[Symptom]> = BehaviorRelay(value: [])
    
    var disposeBag = DisposeBag()
    
    init() {
        symptomsRepository.get(disposeBag: disposeBag) { [weak self] model, error in
            guard error == nil, let model = model else {
                return
            }
            self?.symptoms.accept(model)
        }
    }
}

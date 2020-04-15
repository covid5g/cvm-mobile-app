//
//  ProfileVM.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import RxCocoa
import RxSwift
import Foundation

class ProfileVM {
    let ageRepository = AgeLocal.self
    let genderRepository = GenderLocal.self
    
    var ageGroups: BehaviorRelay<[AgeGroup]> = BehaviorRelay(value: [])
    var genders: BehaviorRelay<[Gender]> = BehaviorRelay(value: [])
    
    var disposeBag = DisposeBag()
    
    init() {
        ageRepository.get(disposeBag: disposeBag) { [weak self] model, error in
            guard error == nil, let model = model else {
                return
            }
            self?.ageGroups.accept(model)
        }
        genderRepository.get(disposeBag: disposeBag) { [weak self] model, error in
            guard error == nil, let model = model else {
                return
            }
            self?.genders.accept(model)
        }
    }
}

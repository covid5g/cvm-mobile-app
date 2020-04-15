//
//  ProfileVC.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import RxSwift
import UIKit

class ProfileVC: UIViewController {

    var disposeBag: DisposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        startSubscriptions()
    }
}

extension ProfileVC {
    func startSubscriptions() {
////        continueButton.rx
//            .tap
//            .subscribe(onNext: { [weak self] _ in
////                MainCoordinator.shared.onAcceptLocation()
//                self?.dismiss(animated: true, completion: nil)
//            }).disposed(by: disposeBag)
    }
    
    func restartSubscriptions() {
        disposeSubscriptions()
        startSubscriptions()
    }
    
    func disposeSubscriptions() {
        disposeBag = DisposeBag()
    }
}

//
//  LocationDisclaimerVC.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import RxSwift
import UIKit

class LocationDisclaimerVC: UIViewController {

    @IBOutlet weak var continueButton: UIButton!
    var disposeBag: DisposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        startSubscriptions()
    }
}

extension LocationDisclaimerVC {
    func startSubscriptions() {
        continueButton.rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                MainCoordinator.shared.onAcceptLocation()
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

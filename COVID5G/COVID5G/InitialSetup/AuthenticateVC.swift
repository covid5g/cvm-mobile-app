//
//  AuthenticateVC.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import RxSwift
import UIKit

class AuthenticateVC: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    var disposeBag: DisposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        startSubscriptions()
    }
}

extension AuthenticateVC {
    func startSubscriptions() {
        loginButton.rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                MainCoordinator.shared.onLogin()
                self?.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        registerButton.rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                MainCoordinator.shared.onRegister()
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

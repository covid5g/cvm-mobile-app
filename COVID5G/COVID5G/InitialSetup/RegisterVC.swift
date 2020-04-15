//
//  RegisterVC.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import RxSwift
import UIKit

class RegisterVC: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var hidePasswordButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    var disposeBag: DisposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        startSubscriptions()
    }
}

extension RegisterVC {
    func startSubscriptions() {
        backButton.rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                MainCoordinator.shared.onBack()
                self?.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        registerButton.rx
        .tap
          .subscribe(onNext: { [weak self] _ in
            MainCoordinator.shared.registerUser()
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

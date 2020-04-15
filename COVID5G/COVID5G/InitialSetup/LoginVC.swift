//
//  LoginVC.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import RxSwift
import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var hidePasswordButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var disposeBag: DisposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        startSubscriptions()
    }
}

extension LoginVC {
    func startSubscriptions() {
        backButton.rx
           .tap
           .subscribe(onNext: { [weak self] _ in
               MainCoordinator.shared.onBack()
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

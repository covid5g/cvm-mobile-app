//
//  MainCoordinator.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/14/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Foundation


protocol Coordinator {
    static var shared: MainCoordinator { get }
    
    var window: UIWindow? { get set }
    var disposeBag: DisposeBag { get set }
    func sceneDelegateDidLoad(withWindow window: UIWindow?)
    
    func start()
}

class MainCoordinator: Coordinator {
    static var shared: MainCoordinator = MainCoordinator()
    var window: UIWindow?
    var navigationController = UINavigationController()
    var disposeBag: DisposeBag = DisposeBag()
    
    private init() {
        navigationController.navigationBar.isHidden = true
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func sceneDelegateDidLoad(withWindow window: UIWindow?) {
        self.window = window
        
        start()
    }
    
    func start() {
        if(!UserDefaults.standard.bool(forKey: "userLogged")) {
            let viewController = Storyboard.Main.disclaimerVC.get()
            navigationController.pushViewController(viewController, animated: true)
            
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        } else {
            let storyboard = UIStoryboard(name: "Symptoms", bundle: nil)
            let viewController = storyboard.instantiateViewController(identifier: "TabHandler")
            navigationController.pushViewController(viewController, animated: true)
            
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
        
    }
}

extension MainCoordinator {
    func onBack() {
        navigationController.popViewController(animated: false)
    }
}


//LocationDisclaimerVC
extension MainCoordinator {
    func onAcceptLocation() {
        let viewController = Storyboard.Main.authenticateVC.get()
        navigationController.pushViewController(viewController, animated: false)
    }
}

//AuthenticateVC
extension MainCoordinator {
    func onRegister() {
        let viewController = Storyboard.Main.registerVC.get()
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func onLogin() {
         let viewController = Storyboard.Main.loginVC.get()
         navigationController.pushViewController(viewController, animated: false)
     }
}

//LoginVC
extension MainCoordinator {
    func registerUser() {
        let viewController = Storyboard.Symptoms.profileVC.get()
        navigationController.pushViewController(viewController, animated: false)
    }
    
}

//RegisterVC
extension MainCoordinator {
    func loginUser() {
        
    }
    
}

//ProfileVC
extension MainCoordinator {
    func onProfileCompleted() {
        UserDefaults.standard.set(true, forKey: "userLogged")
        let viewController = Storyboard.Symptoms.generalVC.get()
        navigationController.pushViewController(viewController, animated: false)
    }
}

//GeneralVC
extension MainCoordinator {
    func onGeneralCompleted() {
        let viewController = Storyboard.Symptoms.symptomsVC.get()
        navigationController.pushViewController(viewController, animated: false)
    }
}

//SymptomsVC
extension MainCoordinator {
    func onSymptomsCompleted() {
        let viewController = Storyboard.Symptoms.preExistingConditionsVC.get()
        navigationController.pushViewController(viewController, animated: false)
    }
}

//PreExistingConditionVC
extension MainCoordinator{
    func onPreExistingConditionVC() {
        let storyboard = UIStoryboard(name: "Symptoms", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "TabHandler")
        navigationController.pushViewController(viewController, animated: true)
    }
}

//
//  SettingsVC.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var settingsTableView: UITableView!
    let settings: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidAppear(_ animated: Bool) {
        getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startSubscriptions()
        settingsTableView.register(UINib(nibName: "SettingCell", bundle: Bundle.main), forCellReuseIdentifier: "SettingCell")
        bindData()
    }
    
}

extension SettingsVC {
    func startSubscriptions() {
        settingsTableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                switch indexPath.row {
                case 0: print(0) //MainCoordinator.shared.showLocations()
                case 1: print(1) //MainCoordinator.shared.showFirstDisclaimer()
                default: break
                }
                
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

extension SettingsVC {
    func getData() {
        settings.accept(["Disclaimer", "Location Disclaimer"])
    }
     func bindData() {
        settings.bind(to: settingsTableView.rx.items(cellIdentifier: "SettingCell",
                                                     cellType: SettingCell.self)) { _, element, cell in
                                                        cell.set(element)
        }.disposed(by: disposeBag)
    }
}

extension SettingsVC {
    func showPFD() {
        
    }
}

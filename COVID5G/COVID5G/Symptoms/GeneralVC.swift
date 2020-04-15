//
//  GeneralVC.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class GeneralVC: UIViewController {
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var generalTableView: UITableView!
    
    
    
    let viewModel = GeneralVM()
    var set = Set<General>()
    var generalScore = 1
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startSubscriptions()
        
        generalTableView.register(UINib(nibName: "GeneralCell", bundle: Bundle.main), forCellReuseIdentifier: "GeneralCell")
        generalTableView.rowHeight = 80
        bindData()
        
        
    }
}

extension GeneralVC {
    func startSubscriptions() {
        continueButton.rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                UserDefaults.standard.set((self!.generalScore*self!.set.count*10), forKey: "generalScore")
                MainCoordinator.shared.onGeneralCompleted()
                self?.dismiss(animated: false, completion: nil)
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

extension GeneralVC {
    func bindData() {
        self.viewModel.generalQuestions.bind(to: generalTableView.rx.items(cellIdentifier: "GeneralCell",
                                                                           cellType: GeneralCell.self)) { _, element, cell in
                                                                            cell.set(element)
                                                                            cell.generalSwitch.rx.isOn.changed
                                                                                .distinctUntilChanged().asObservable()
                                                                                .subscribe(onNext: { [weak self] value in
                                                                                    self?.setGeneral(element: element, value: value)
                                                                                    
                                                                                }).disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
    }
    
    
    func setGeneral(element: General, value: Bool) {
        if value {
            self.set.insert(element)
        } else {
            set = set.filter { $0.question != element.question }
        }
    }
}

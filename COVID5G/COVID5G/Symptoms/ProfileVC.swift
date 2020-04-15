//
//  ProfileVC.swift
//  COVID5G
//
//  Created by Darius-George Oanea on 4/15/20.
//  Copyright © 2020 covid5g. All rights reserved.
//

import RxSwift
import UIKit

class ProfileVC: UIViewController, UITextViewDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    let viewModel = ProfileVM()
    var disposeBag: DisposeBag = DisposeBag()
    
    let countries = ["Romania", "Other Country"]
    let countriesPickerView = UIPickerView()
    let genderPickerView2 = UIPickerView()
    let agePickerView2 = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startSubscriptions()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        countriesPickerView.tag = 0
        agePickerView2.tag = 1
        genderPickerView2.tag = 2
        countriesPickerView.delegate = self
        countriesPickerView.dataSource = self
        genderPickerView2.delegate = self
        genderPickerView2.dataSource = self
        agePickerView2.delegate = self
        agePickerView2.dataSource = self
        countryTextField.inputView = countriesPickerView
        ageTextField.inputView = agePickerView2
        genderTextField.inputView = genderPickerView2
        continueButton.isEnabled = false
    }
}

extension ProfileVC {
    func startSubscriptions() {
        continueButton.rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                MainCoordinator.shared.onProfileCompleted()
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

extension ProfileVC {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ProfileVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0: return countries.count
        case 1: return viewModel.ageGroups.value.count
        case 2: return viewModel.genders.value.count
        default:
            return 4
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0: return countries[row]
        case 1: return viewModel.ageGroups.value[row].group
        case 2: return viewModel.genders.value[row].gender
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0: countryTextField.text = countries[row]
        case 1: ageTextField.text = viewModel.ageGroups.value[row].group
        case 2: genderTextField.text = viewModel.genders.value[row].gender; continueButton.isEnabled = true
        default: break
        }
    }
    
}

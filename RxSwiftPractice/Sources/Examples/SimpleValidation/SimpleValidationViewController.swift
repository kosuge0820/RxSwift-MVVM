//
//  SimpleValidationViewController.swift
//  RxSwiftPractice
//
//  Created by k-satoshi on 2017/03/16.
//  Copyright © 2017年 k-satoshi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SimpleValidationViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameValidationLabel: UILabel!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    private let minimalUsernameLength = 5
    private let minimalPasswordLength = 5
    private let disposeBag = DisposeBag()
    
    //orEmpty: 空文字やnilはオブザーブしない
    private var usernameValidation: Observable<Bool> {
        return usernameTextField.rx.text.orEmpty
            .map { $0.characters.count >= self.minimalUsernameLength }
            .shareReplay(1)
    }
    
    private var passwordValidation: Observable<Bool> {
        return passwordTextField.rx.text.orEmpty
            .map { $0.characters.count >= self.minimalPasswordLength }
            .shareReplay(1)
    }
    
    private var buttonValidation: Observable<Bool> {
        return Observable.combineLatest(usernameValidation, passwordValidation) { $0 && $1 }
            .shareReplay(1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
        bind()
    }
    
    private func bind() {
        usernameValidation
            .bindTo(usernameValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValidation
            .bindTo(passwordValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        buttonValidation
            .bindTo(signUpButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signUpButton.rx.tap
            .subscribe(onNext: { [weak self] in self?.showAlert() })
            .disposed(by: disposeBag)
    }
    
    private func initial() {
        usernameValidationLabel.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidationLabel.text = "Password has to be at least \(minimalPasswordLength) characters"
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Success", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "close", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

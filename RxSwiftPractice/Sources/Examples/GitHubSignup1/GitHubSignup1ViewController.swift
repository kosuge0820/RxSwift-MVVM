//
//  GitHubSignup1ViewController.swift
//  RxSwiftPractice
//
//  Created by k-satoshi on 2017/03/16.
//  Copyright © 2017年 k-satoshi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GitHubSignup1ViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameValidationLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    
    @IBOutlet weak var repeatTextField: UITextField!
    @IBOutlet weak var repeatLabel: UILabel!
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var signupActivityIndicatorView: UIActivityIndicatorView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = GithubSignupViewModel1(
            input: (username: usernameTextField.rx.text.orEmpty.asObservable(),
                    password: passwordTextField.rx.text.orEmpty.asObservable(),
                    repeatedPassword: repeatTextField.rx.text.orEmpty.asObservable(),
                    loginTaps: signupButton.rx.tap.asObservable()),
            dependency: (
                API: GitHubDefaultAPI.sharedAPI,
                validationService: GitHubDefaultValidationService.shared,
                wireframe: DefaultWireframe.shared
            )
        )
        
        viewModel.signupEnabled
            .subscribe { [weak self] valid in
                self?.signupButton.isEnabled = valid.element!
                self?.signupButton.alpha = valid.element! ? 1.0 : 0.5
            }
            .disposed(by: disposeBag)
        
        viewModel.validatedUsername
            .bindTo(usernameValidationLabel.rx.validationResult)
            .disposed(by: disposeBag)
        
        viewModel.validatedPassword
            .bindTo(passwordValidationLabel.rx.validationResult)
            .disposed(by: disposeBag)
        
        viewModel.validatedPasswordRepeated
            .bindTo(repeatLabel.rx.validationResult)
            .disposed(by: disposeBag)
        
        viewModel.signingIn
            .bindTo(signupActivityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.signedIn
            .subscribe { signedIn in
                print("user signed in \(signedIn)")
            }
            .disposed(by: disposeBag)
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.rx.event
            .subscribe { [weak self] _ in
                self?.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        view.addGestureRecognizer(tapGesture)
    }
}

//
//  GitHubSignup2ViewController.swift
//  RxSwiftPractice
//
//  Created by k-satoshi on 2017/03/16.
//  Copyright © 2017年 k-satoshi. All rights reserved.
//

import UIKit

class GitHubSignup2ViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameValidationLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordValidationLabel: UILabel!
    
    @IBOutlet weak var loadingActivityView: UIActivityIndicatorView!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = GithubSignupViewModel2(
            input: (
                username: usernameTextField.rx.text.orEmpty.asDriver(),
                password: passwordTextField.rx.text.orEmpty.asDriver(),
                repeatedPassword: confirmPasswordTextField.rx.text.orEmpty.asDriver(),
                loginTaps: signUpButton.rx.tap.asDriver()
            ),
            dependency: <#T##(API: GitHubAPI, validationService: GitHubValidationService, wireframe: Wireframe)#>)
    }
}

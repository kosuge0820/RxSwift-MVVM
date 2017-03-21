//
//  NumbersViewController.swift
//  RxSwift+MVVM
//
//  Created by k-satoshi on 2017/03/13.
//  Copyright © 2017年 k-satoshi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NumbersViewController: UIViewController {

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        combineLatest()
    }
    
    private func combineLatest() {
        Observable.combineLatest(textField1.rx.text.orEmpty, textField2.rx.text.orEmpty, textField3.rx.text.orEmpty) { value1, value2, value3 -> Int in
            return (Int(value1) ?? 0) + (Int(value2) ?? 0) + (Int(value3) ?? 0)
        }
        .map { $0.description }
        .bindTo(resultLabel.rx.text)
        .disposed(by: disposeBag)
    }
}

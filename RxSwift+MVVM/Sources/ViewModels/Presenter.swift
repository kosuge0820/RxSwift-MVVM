//
//  Presenter.swift
//  RxSwift+MVVM
//
//  Created by k-satoshi on 2017/03/13.
//  Copyright © 2017年 k-satoshi. All rights reserved.
//

import UIKit
import RxSwift

class Presenter {
    private let buttonHiddenSubject = Variable(false)

    var buttonHidden: Observable<Bool> { return buttonHiddenSubject.asObservable() }
    
    func start() {
        buttonHiddenSubject.value = true
    }
    
    func stop() {
        buttonHiddenSubject.value = false
    }
}

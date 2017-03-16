//
//  ViewModel.swift
//  RxSwift+MVVM
//
//  Created by k-satoshi on 2017/03/13.
//  Copyright © 2017年 k-satoshi. All rights reserved.
//

import UIKit
import RxSwift

class ViewModel {
    private let eventSubject = PublishSubject<Int>()

    var event: Observable<Int> { return eventSubject }
    
    func doSomething() {
        print("1")
        eventSubject.onNext(1000)
        print("3")
    }
}

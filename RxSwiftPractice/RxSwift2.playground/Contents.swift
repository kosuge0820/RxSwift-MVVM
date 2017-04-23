//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import RxCocoa

//MARK: - PublishSubject
example(of: "PublishSubject") {
    let subject = PublishSubject<String>()
    subject.onNext("Is anyone listening")
    
    let subscriptionOne = subject.subscribe(onNext: {
        print($0)
    })
    
    subject.on(.next("1"))
    subject.onNext("2")
    
    let subscriptionTwo = subject
        .subscribe { event in
            print("2", event.element ?? event)
    }
    subject.onNext("3")
    
    subscriptionOne.dispose()
    
    subject.onNext("4")
    
    subject.onCompleted()
    
    subject.onNext("5")
    
    subscriptionTwo.dispose()
    
    let disposeBag = DisposeBag()
    
    subject.subscribe {
        print("3", $0.element ?? $0)
        }
        .disposed(by: disposeBag)
    
    subject.onNext("?")
}

enum MyError: Error { case anError }

func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, event.element ?? event.error ?? event)
}

//MARK: - BehaviorSubject
example(of: "BehaviorSubject") {
    let subject = BehaviorSubject(value: "Initial value")
    let disposeBag = DisposeBag()
    
    subject.onNext("X")
    subject.subscribe {
        print(label: "1", event: $0)
        }
        .disposed(by: disposeBag)
    
    subject.onError(MyError.anError)
    
    subject.subscribe {
        print(label: "2", event: $0)
        }
        .disposed(by: disposeBag)
}

//MARK: - ReplaySubject
example(of: "ReplaySubject") {
    let subject = ReplaySubject<String>.create(bufferSize: 2)
    let disposeBag = DisposeBag()
    
    subject.onNext("1")
    subject.onNext("2")
    subject.onNext("3")
    
    subject.subscribe {
        print(label: "1", event: $0)
        }
        .disposed(by: disposeBag)
    
    subject.subscribe {
        print(label: "2", event: $0)
        }
        .disposed(by: disposeBag)
    
    subject.onNext("4")
    subject.onError(MyError.anError)
    subject.dispose()
    
    subject.subscribe {
        print(label: "3", event: $0)
        }
        .disposed(by: disposeBag)
}

//MARK: - Variable
example(of: "Variable") {
    let variable = Variable("Initial value")
    let disposeBag = DisposeBag()
    
    variable.value = "New initial value"
    
    variable.asObservable()
        .subscribe {
            print(label: "1", event: $0)
        }
        .disposed(by: disposeBag)
    
    variable.value = "1"
    
    variable.asObservable()
        .subscribe {
            print(label: "2", event: $0)
        }
        .disposed(by: disposeBag)
    
    variable.value = "2"
}

example(of: "ignoreElements") {
    let strikes = PublishSubject<String>()
    let disposeBag = DisposeBag()
    
    strikes
        .ignoreElements()
        .subscribe { _ in
            print("You` re out!")
        }
        .disposed(by: disposeBag)
    
    strikes.onNext("X")
    strikes.onNext("X")
    strikes.onNext("X")
    strikes.onCompleted()
}

example(of: "elementAt") {
    let strikes = PublishSubject<String>()
    let disposeBag = DisposeBag()
    
    strikes
        .elementAt(2)
        .subscribe(onNext: { _ in
            print("You 're out!")
        })
        .disposed(by: disposeBag)
    
    strikes.onNext("X")
    strikes.onNext("X")
    strikes.onNext("X")
}


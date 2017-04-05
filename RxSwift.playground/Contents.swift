/*:

## RxSwift Practice

*/

import UIKit
import RxSwift
import PlaygroundSupport

let one = 1
let two = 2
let three = 3

/*:
__just:__ 単一の要素
 */

example(of: "just") {
    let observable = Observable<Int>.just(one)
    observable.subscribe(onNext: {
        print($0)
    })
}

/*:
__of:__  定数のイベントストリームの生成
 */

example(of: "of") {
    let observable = Observable.of(one, two, three)
    let observable1 = Observable.of([one, two, three])
    
    observable.subscribe(onNext: {
        print($0)
    })
    
    observable1.subscribe(onNext: {
        print($0)
    })
}

/*:
__from:__ 配列をObservableに変換
 */

example(of: "from") { 
    let observable = Observable.from([one, two, three])
    observable.subscribe(onNext: {
        print($0)
    })
}

/*:
__subscribe:__ イベントの登録
 */

example(of: "subscribe") {
    let observable = Observable.of(one, two, three)
    observable.subscribe(onNext: {
        print($0)
    })
}

/*:
__empty:__ 値を持たず、正常に終了するObservableを生成
*/

example(of: "empty") { 
    let observable = Observable<Void>.empty()
    observable.subscribe(
        onNext: {
            print($0) //skip
        }, onCompleted: {
            print("Completed")
        }
    )
}


/*:
__never:__ 値を持たず、終了しないObservableを生成
 */
example(of: "never") {
    let observable = Observable<Any>.never()
    observable.subscribe(
        onNext: {
            print($0)
        }, onCompleted: {
            print("Completed")
        }
    )
}

/*:
__range:__ 特定の範囲の整数を元にObservableを生成します
*/

//MARK: - range
example(of: "range") { 
    let observable = Observable<Int>.range(start: 1, count: 10)
    observable.subscribe(
        onNext: { i in
            let n = Double(i)
            let fibonacci = Int((pow(1.61803, n) - pow(0.61803, n)) / 2.23606.rounded())
            print(fibonacci)
        }
    )
}

/*:
__dispose:__ データバインドの解除
*/

//MARK: - dispose
example(of: "dispose") {
    let observable = Observable.of("A", "B", "C")
    let subscription = observable.subscribe {
        print($0)
    }
    subscription.dispose()
}

/*:
 __DisposeBag:__ データバインドの解除
 */

//MARK: - DisposeBag
example(of: "DisposeBag") { 
    let disposeBag = DisposeBag()
    Observable.of("A", "B", "C")
        .subscribe {
            print($0)
        }
        .disposed(by: disposeBag)
}

/*:
__create:__ 関数からObservableを生成
*/

//MARK: - create
example(of: "create") { 
    enum CreateError: Error { case anError }
    
    let disposeBag = DisposeBag()
    
    Observable<String>.create { observer in
        observer.onNext("1")
//        observer.onError(CreateError.anError) // skip "?"
//        observer.onCompleted()                // skip "?"
        observer.onNext("?")
        return Disposables.create()
    }
    .subscribe(
        onNext: { print($0) },
        onError: { print($0) },
        onCompleted: { print("Completed") },
        onDisposed: { print("Disposed") }
    )
    .disposed(by: disposeBag)
}

extension Bool {
    mutating func flip() -> Bool {
        return !self
    }
}

/*:
 __deferred:__
 */

//MARK: - deferred
example(of: "deferred") { 
    let disposeBag = DisposeBag()
    var flip = false
    let factory: Observable<Int> = Observable.deferred {
        flip.flip()
        
        if flip {
            return Observable.of(1, 2, 3)
        } else {
            return Observable.of(4, 5, 6)
        }
    }
    
    for _ in 0...3 {
        factory.subscribe(onNext: {
            print($0, terminator: "")
        })
        .disposed(by: disposeBag)
    }
}

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






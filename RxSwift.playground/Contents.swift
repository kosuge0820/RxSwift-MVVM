/*:

## RxSwift Practice

*/

import UIKit
import RxSwift

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
    observable.subscribe(onNext: { element in
        print(element)
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

example(of: "DisposeBag") { 
    let disposeBag = DisposeBag()
    Observable.of("A", "B", "C")
        .subscribe {
            print($0)
        }
        .disposed(by: disposeBag)
}



















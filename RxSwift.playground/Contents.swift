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

//__ empty:__ 値を持たず、正常に終了するObservableを生成

example(of: "empty") { 
    let observable = Observable<Void>.empty()
    observable.subscribe(
        onNext: {
            print($0) //skip
        }, onCompleted: {
            print("complete")
        }
    )
}














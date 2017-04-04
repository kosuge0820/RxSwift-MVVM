/*:

## RxSwift Practice

*/

import UIKit
import RxSwift

example(of: "just, of, from") { 
    let one = 1
    let two = 2
    let three = 3
    
    let observable = Observable<Int>.just(one)
    let observable1 = Observable.of(one, two, three)
    let observable2 = Observable.of([one, two, three])
    let observable3 = Observable.from([one, two, three])
    
    
    print(observable)
    print(observable1)
}
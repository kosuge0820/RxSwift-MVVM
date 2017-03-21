//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by k-satoshi on 2017/03/13.
//  Copyright © 2017年 k-satoshi. All rights reserved.
//

import UIKit
import RxSwift //
import RxCocoa //UIのBind  ex: BindTo

class FirstViewController: UIViewController {
    private let viewModel = ViewModel()
    private let presenter = Presenter()
    private let disposeBag = DisposeBag()
    
    private lazy var customView: CustomView = {
        let view = CustomView(frame: self.view.frame)
        view.customButton.addTarget(self, action: #selector(tapped), for: UIControlEvents.touchUpInside)
        return view
    }()

    override func loadView() {
        super.loadView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonHiddenObservale()
    }

    //MARK: - Demo2
    private func buttonHiddenObservale() {
        presenter.buttonHidden
            .bindTo(customView.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    func tapped() {
        presenter.start()
    }
}

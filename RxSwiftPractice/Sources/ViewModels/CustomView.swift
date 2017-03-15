//
//  CustomView.swift
//  RxSwift+MVVM
//
//  Created by k-satoshi on 2017/03/13.
//  Copyright © 2017年 k-satoshi. All rights reserved.
//

import UIKit

final class CustomView: UIView {
    lazy var customButton: UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width: 100, height: 100)
        button.center = self.center
        button.backgroundColor = UIColor.yellow
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(customButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

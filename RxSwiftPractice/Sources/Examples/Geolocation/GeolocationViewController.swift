//
//  GeolocationViewController.swift
//  RxSwiftPractice
//
//  Created by k-satoshi on 2017/03/16.
//  Copyright © 2017年 k-satoshi. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import CoreLocation

class GeolocationViewController: UIViewController {
    @IBOutlet var noGeolocationView: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(noGeolocationView)
    }
}

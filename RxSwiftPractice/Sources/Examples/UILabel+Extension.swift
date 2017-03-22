//
//  UILabel+Extension.swift
//  RxSwiftPractice
//
//  Created by k-satoshi on 2017/03/22.
//  Copyright © 2017年 k-satoshi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CoreLocation

extension Reactive where Base: UILabel {
    var coordinates: UIBindingObserver<Base, CLLocationCoordinate2D> {
        return UIBindingObserver(UIElement: base, binding: { (label, location) in
            label.text = "Lat: \(location.latitude)\nLon: \(location.longitude)"
        })
    }
    
    var validationResult: UIBindingObserver<Base, ValidationResult> {
        return UIBindingObserver(UIElement: base) { label, result in
            label.textColor = result.textColor
            label.text = result.description
        }
    }
}

struct ValidationColors {
    static let okColor = UIColor(red: 138.0 / 255.0, green: 221.0 / 255.0, blue: 109.0 / 255.0, alpha: 1.0)
    static let errorColor = UIColor.red
}

extension ValidationResult: CustomStringConvertible {
    var description: String {
        switch self {
        case let .ok(message):
            return message
        case .empty:
            return ""
        case .validating:
            return "validating ..."
        case let .failed(message):
            return message
        }
    }
}

extension ValidationResult {
    var textColor: UIColor {
        switch self {
        case .ok:
            return ValidationColors.okColor
        case .empty:
            return UIColor.black
        case .validating:
            return UIColor.black
        case .failed:
            return ValidationColors.errorColor
        }
    }
}

//
//  GitHubDefaultAPI.swift
//  RxSwiftPractice
//
//  Created by k-satoshi on 2017/03/22.
//  Copyright © 2017年 k-satoshi. All rights reserved.
//

import UIKit
import Foundation
import RxSwift

fileprivate extension String {
    var URLEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
}

class GitHubDefaultValidationService: GitHubValidationService {
    let API: GitHubAPI
    let minPasswordCount = 5
    static let shared = GitHubDefaultValidationService(API: GitHubDefaultAPI.sharedAPI)
    
    init(API: GitHubAPI) {
        self.API = API
    }
    
    func validateUsername(_ username: String) -> Observable<ValidationResult> {
        if username.characters.count == 0 {
            return .just(.empty)
        }
        
        let loadingValue = ValidationResult.validating
        
        return API
            .usernameAvailable(username)
            .map { available in
                if available {
                    return .ok(message: "username available")
                } else {
                    return .failed(message: "username already taken")
                }
            }
            .startWith(loadingValue)
    }
    
    func validatePassword(_ password: String) -> ValidationResult {
        let numberOfCharacters = password.characters.count
        if numberOfCharacters == 0 {
            return .empty
        }
        
        if numberOfCharacters < minPasswordCount {
            return .failed(message: "password must be at least \(minPasswordCount) characters")
        }
        
        return .ok(message: "password acceptable")
    }
    
    func validateRepeatedPassword(_ password: String, repeatedPassword: String) -> ValidationResult {
        if repeatedPassword.characters.count == 0 {
            return .empty
        }
        
        if repeatedPassword == password {
            return .ok(message: "password repeated")
        } else {
            return .failed(message: "password different")
        }
    }
}

class GitHubDefaultAPI: GitHubAPI {
    let urlSession: Foundation.URLSession
    
    static let sharedAPI = GitHubDefaultAPI(
        urlSession: Foundation.URLSession.shared
    )
    
    init(urlSession: Foundation.URLSession) {
        self.urlSession = urlSession
    }
    
    func usernameAvailable(_ username: String) -> Observable<Bool> {
        let url = URL(string: "https://github.com/\(username.URLEscaped)")!
        let request = URLRequest(url: url)
        return self.urlSession.rx.response(request: request)
            .map { (response, _ ) in
                return response.statusCode == 404
            }
            .catchErrorJustReturn(false)
    }
    
    func signup(_ username: String, password: String) -> Observable<Bool> {
        let signupResult = arc4random() % 5 == 0 ? false : true
        return Observable.just(signupResult)
            .delay(1.0, scheduler: MainScheduler.instance)
    }
}

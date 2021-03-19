//
//  UserService.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/13/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import FirebaseAuth

class Network {
    typealias StatusBlock = ((_ error: Error?) -> Void)
}

class UserService {
    func registration(email: String, password: String, success: @escaping (FirebaseAuth.User) -> Void, fail: @escaping Network.StatusBlock) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let user = authResult?.user, error == nil else {
                fail(error)
                return
            }
            success(user)
        }
    }
    
    func authorization(email: String,
                       password: String,
                       success: @escaping(FirebaseAuth.User) -> Void,
                       fail: @escaping Network.StatusBlock) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            guard let user = authResult?.user, error == nil else {
                fail(error)
                return
            }
            success(user)
        }
    }
}

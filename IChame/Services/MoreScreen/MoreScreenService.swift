//
//  MoreScreenService.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/27/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//


import Foundation
import FirebaseAuth

class MoreScreenService {
    
    func logout(success: @escaping (Bool?) -> Void, fail: @escaping Network.StatusBlock) {
        User.current = nil
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            success(true)
        } catch let signOutError as NSError {
            fail(signOutError)
            print ("Error signing out: %@", signOutError)
        }
    }
}

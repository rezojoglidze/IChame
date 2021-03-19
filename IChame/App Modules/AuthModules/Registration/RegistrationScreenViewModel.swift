//
//  RegistrationScreenViewModel.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/12/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator
import FirebaseAuth
import RxSwift
import RxCocoa

protocol RegistrationScreenViewModelDelegate {
    var router: UnownedRouter<AuthRoute> { get }
    
    var userDidRegister: Observable<Void> { get }
    
    func registration(email: String, password: String, fail: @escaping Network.StatusBlock)
}

class RegistrationScreenViewModel {
    
    var router: UnownedRouter<AuthRoute>
    var userService: UserService?
    
    let userDidRegister: Observable<Void>
    let innerUserDidRegister: PublishRelay<Void> = PublishRelay<Void>()
    
    init(router: UnownedRouter<AuthRoute>, userService: UserService?) {
        self.router = router
        self.userService = userService
        self.userDidRegister = self.innerUserDidRegister.asObservable()
    }
}

extension RegistrationScreenViewModel: RegistrationScreenViewModelDelegate {
    func registration(email: String, password: String, fail: @escaping Network.StatusBlock) {
        userService?.registration(email: email, password: password, success: { [weak self] (user) in
            self?.innerUserDidRegister.accept(())
        }, fail: fail)
    }
}

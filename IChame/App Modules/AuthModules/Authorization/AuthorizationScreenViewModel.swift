//
//  AuthorizationScreenViewModel.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/11/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator
import RxSwift
import RxCocoa

protocol AuthorizationScreenViewModelProtocol {
  var router: UnownedRouter<AuthRoute> { get }
  
  var userDidLogin: Observable<Void> { get }
  
  func acountHaveNotBtnTapped()
  
  func authorization(email: String, password: String, fail: @escaping Network.StatusBlock)
}

class AuthorizationScreenViewModel {
  var router: UnownedRouter<AuthRoute>
  var userService: UserService?
  
  let userDidLogin: Observable<Void>
  let innerUserDidLogin: PublishRelay<Void> = PublishRelay<Void>()
  
  init(router: UnownedRouter<AuthRoute>, userService: UserService?) {
    self.router = router
    self.userService = userService
    self.userDidLogin = self.innerUserDidLogin.asObservable()
  }
}

extension AuthorizationScreenViewModel: AuthorizationScreenViewModelProtocol {
  func authorization(email: String, password: String, fail: @escaping Network.StatusBlock) {
    userService?.authorization(email: email, password: password, success: { [weak self] (user) in
      User.current = user
      self?.innerUserDidLogin.accept(())
    }, fail: fail)
  }
  
  func acountHaveNotBtnTapped() {
    router.trigger(.registrationScreen)
  }
}

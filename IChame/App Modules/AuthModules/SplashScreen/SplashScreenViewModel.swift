//
//  SplashScreenViewModel.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/10/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator
import FirebaseAuth

protocol SplashScreenViewModelProtocol {
    var router: UnownedRouter<MainRoute> { get }
    func triggerSplashScreenCompletion()
}

class SplashScreenViewModel {
    
    var router: UnownedRouter<MainRoute>
    
    init(router: UnownedRouter<MainRoute>) {
        self.router = router
    }
}

extension SplashScreenViewModel: SplashScreenViewModelProtocol {
    func triggerSplashScreenCompletion() {
        if let user = Auth.auth().currentUser {
            User.current = user
            router.trigger(.authorizationScreen(initialRoute: .scannerScreen))
        } else {
            router.trigger(.authorizationScreen(initialRoute: .authScreen))
        }
    }
}

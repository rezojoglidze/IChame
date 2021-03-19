//
//  ScannerScreenViewModel.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/14/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator
import Firebase
import RxSwift
import RxCocoa

protocol ScannerScreenViewModelProocol {
    var router: UnownedRouter<AuthRoute> { get }
    
    func getMenu(docId: String, fail: @escaping Network.StatusBlock)
    
    var menuDidLoaded: Observable<Void> { get }
}

class ScannerScreenViewModel {
    var router: UnownedRouter<AuthRoute>
    let menuService: MenuService?
    private var db: Firestore?
    
    let menuDidLoaded: Observable<Void>
    let innerMenuDidLoaded: PublishRelay<Void> = PublishRelay<Void>()
    
    init(router: UnownedRouter<AuthRoute>, menuService: MenuService?) {
        self.router = router
        self.menuService = menuService
        self.db = Firestore.firestore()
        self.menuDidLoaded = self.innerMenuDidLoaded.asObservable()
    }
}


extension ScannerScreenViewModel: ScannerScreenViewModelProocol {
    func getMenu(docId: String, fail: @escaping Network.StatusBlock) {
        self.menuService?.getMenu(docId: docId, success: { [weak self] (menu) in
            self?.innerMenuDidLoaded.accept(())
            self?.router.trigger(.mainTabbarScreen(menu: menu))
        }, fail: fail)
    }
}

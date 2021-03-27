//
//  MenuDetailsScreenViewModel.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/19/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator
import RxSwift
import RxCocoa

protocol MenuDetailsScreenViewModelProtocol {
    var router: StrongRouter<MenuRoute> { get }
    var showLoader: Observable<Bool> { get }

    func numberOfRows() -> Int
    
    func item(at indexPath: IndexPath) -> MenuItem?
    
    func addButtonTapped(with indexPath: IndexPath, fail: @escaping Network.StatusBlock)
}

class MenuDetailsScreenViewModel {
    
    var router: StrongRouter<MenuRoute>
    var bucketService: BucketService?
    
    private var menuItems: [MenuItem]

    var showLoader: Observable<Bool>
    let showLoaderRelay: PublishRelay<Bool> = PublishRelay<Bool>()

    init(router: StrongRouter<MenuRoute>,
         menuItems: [MenuItem],
         bucketService: BucketService?) {
        self.router = router
        self.bucketService = bucketService
        self.menuItems = menuItems
        self.showLoader = self.showLoaderRelay.asObservable()
    }
}

extension MenuDetailsScreenViewModel: MenuDetailsScreenViewModelProtocol {
    func addButtonTapped(with indexPath: IndexPath, fail: @escaping Network.StatusBlock) {

        bucketService?.addDish(Menu.currentMenuId, with: menuItems[indexPath.row], userId: User.current?.uid ?? "", success: {[weak self] (isAdded) in
//            self?.showLoaderRelay.accept(false)
        }, fail: fail)
    }
    
    func numberOfRows() -> Int {
        return menuItems.count
    }
    
    func item(at indexPath: IndexPath) -> MenuItem? {
        if menuItems.indices.contains(indexPath.row) {
            return menuItems[indexPath.row]
        }
        return nil
    }
}

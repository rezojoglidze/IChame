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
    var isAddedDish: Observable<Void> { get }
    var isRemovedDish: Observable<Void> { get }

    func numberOfRows() -> Int
    
    func item(at indexPath: IndexPath) -> MenuItem?
    
    func actionButtonTapped(with indexPath: IndexPath, isAdd: Bool, fail: @escaping Network.StatusBlock)
}
class MenuDetailsScreenViewModel {
    
    var router: StrongRouter<MenuRoute>
    var bucketService: BucketService?
    
    private var menuItems: [MenuItem]

    var isAddedDish: Observable<Void>
    var isRemovedDish: Observable<Void>
    let innerIsAddedDish: PublishRelay<Void> = PublishRelay<Void>()
    let innerIsRemovedDish: PublishRelay<Void> = PublishRelay<Void>()

    init(router: StrongRouter<MenuRoute>,
         menuItems: [MenuItem],
         bucketService: BucketService?) {
        self.router = router
        self.bucketService = bucketService
        self.menuItems = menuItems
        self.isAddedDish = self.innerIsAddedDish.asObservable()
        self.isRemovedDish = self.innerIsRemovedDish.asObservable()
    }
}

extension MenuDetailsScreenViewModel: MenuDetailsScreenViewModelProtocol {
    func actionButtonTapped(with indexPath: IndexPath, isAdd: Bool, fail: @escaping Network.StatusBlock) {
        let menuId = Menu.currentMenuId
        let menuItem = menuItems[indexPath.row]
        let userId = User.current?.uid ?? ""
        if isAdd {
            bucketService?.addDish(menuId, with: menuItem, userId: userId, index: indexPath.row, success: {[weak self] (isAdded) in
                self?.innerIsAddedDish.accept(())
            }, fail: fail)
        } else {
            bucketService?.removeDish(menuId, with: menuItem, userId: userId, index: indexPath.row, success: {[weak self] (isRemoved) in
                self?.innerIsRemovedDish.accept(())
            }, fail: fail)
        }
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

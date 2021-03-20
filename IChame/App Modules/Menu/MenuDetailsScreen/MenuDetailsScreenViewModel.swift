//
//  MenuDetailsScreenViewModel.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/19/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator

protocol MenuDetailsScreenViewModelProtocol {
    var router: StrongRouter<MenuRoute> { get }
    
    func numberOfRows() -> Int
    
    func item(at indexPath: IndexPath) -> MenuItem?
    
    func actionButtonTapped(with indexPath: IndexPath, isAdd: Bool, fail: @escaping Network.StatusBlock)
}
class MenuDetailsScreenViewModel {
    
    var router: StrongRouter<MenuRoute>
    var bucketService: BucketService?
    
    private var menuItems: [MenuItem]

    init(router: StrongRouter<MenuRoute>,
         menuItems: [MenuItem],
         bucketService: BucketService?) {
        self.router = router
        self.bucketService = bucketService
        self.menuItems = menuItems
    }
}

extension MenuDetailsScreenViewModel: MenuDetailsScreenViewModelProtocol {
    func actionButtonTapped(with indexPath: IndexPath, isAdd: Bool, fail: @escaping Network.StatusBlock) {
        let menuId = Menu.currentMenuId
        let menuItem = menuItems[indexPath.row]
        bucketService?.addDish(menuId, with: menuItem, userId: User.current?.uid ?? "", index: indexPath.row, success: { (isAdd) in
            print("isAdd isAdd isAdd -> ", isAdd)
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

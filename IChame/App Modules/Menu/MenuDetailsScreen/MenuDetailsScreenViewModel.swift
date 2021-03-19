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
}
class MenuDetailsScreenViewModel {
    
    var router: StrongRouter<MenuRoute>
    
    private var menuItems: [MenuItem]
    
    init(router: StrongRouter<MenuRoute>, menuItems: [MenuItem]) {
        self.router = router
        self.menuItems = menuItems
    }
}

extension MenuDetailsScreenViewModel: MenuDetailsScreenViewModelProtocol {
    func numberOfRows() -> Int {
        return menuItems.count
    }
    
    func item(at indexPath: IndexPath) -> MenuItem? {
        return menuItems[indexPath.row]
    }
}

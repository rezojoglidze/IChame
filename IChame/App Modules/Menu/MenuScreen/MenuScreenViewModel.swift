//
//  HomeScreenViewModel.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/18/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator

protocol MenuScreenViewModelProtocol {
    var router: StrongRouter<MenuRoute> { get }
    
    func item(at indexPath: IndexPath) -> (type: MenuType, img: UIImage?)?
    
    func openMenuDetails(with indexPath: IndexPath)
}

class MenuScreenViewModel {
    var router: StrongRouter<MenuRoute>
    
    private var menu: Menu?
    
    init(router: StrongRouter<MenuRoute>, menu: Menu?) {
        self.router = router
        self.menu = menu
    }
}

extension MenuScreenViewModel: MenuScreenViewModelProtocol {
    func openMenuDetails(with indexPath: IndexPath) {
        guard let item = menu?.menuScreenDataSource[indexPath.row],
              let menu = self.menu else { return }
        
        let menuItems = item.type.getMenuItems(from: menu)
        router.trigger(.menuDetails(menuItems: menuItems, title: item.type.title))
    }
    
    func item(at indexPath: IndexPath) -> (type: MenuType, img: UIImage?)? {
        return menu?.menuScreenDataSource[indexPath.row]
    }
}

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
    
}

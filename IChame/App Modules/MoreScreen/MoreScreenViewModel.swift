//
//  MoreScreenViewModel.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/19/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator

protocol MoreScreenViewModelProtocol {
    var router: StrongRouter<MoreSceenRoute> { get }
}

class MoreScreenViewModel {
    var router: StrongRouter<MoreSceenRoute>
    
    init(router: StrongRouter<MoreSceenRoute>) {
        self.router = router
    }
}

extension MoreScreenViewModel: MoreScreenViewModelProtocol {
    
}

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
    
    func numberOfRows() -> Int
    
    func itemAt(index: Int) -> Field
    
    func logout(fail: @escaping Network.StatusBlock)
}

class MoreScreenViewModel {
    var router: StrongRouter<MoreSceenRoute>
    var moreScreenService: MoreScreenService?
    var moreData = More()

    init(router: StrongRouter<MoreSceenRoute>,
         moreScreenService: MoreScreenService?) {
        self.router = router
        self.moreScreenService = moreScreenService
    }
}

extension MoreScreenViewModel: MoreScreenViewModelProtocol {
    func numberOfRows() -> Int {
        return moreData.fields.count
    }
    
    func itemAt(index: Int) -> Field {
        return moreData.fields[index]
    }
    
    func logout(fail: @escaping Network.StatusBlock) {
        moreScreenService?.logout(success: { [weak self] _ in
            self?.router.trigger(.logout)
        }, fail: fail)
    }
}

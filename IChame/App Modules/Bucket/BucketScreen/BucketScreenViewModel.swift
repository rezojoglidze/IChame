//
//  BucketScreenViewModel.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/19/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator

protocol BucketScreenViewModelProtocol {
    var router: StrongRouter<BucketRoute> { get }
    
    func loadBucket(fail: @escaping Network.StatusBlock)
}

class BucketScreenViewModel {
    var router: StrongRouter<BucketRoute>
    var bucketService: BucketService?
    
    init(router: StrongRouter<BucketRoute>,
         bucketService: BucketService?) {
        self.router = router
        self.bucketService = bucketService
    }
}

extension BucketScreenViewModel: BucketScreenViewModelProtocol {
    func loadBucket(fail: @escaping Network.StatusBlock) {
        let menuId = Menu.currentMenuId
        let userId = User.current?.uid ?? ""
        bucketService?.loadBucket(menuId, userId: userId, success: { (buckets) in
            print("buckets ---> ",buckets)
        }, fail: fail)
    }
}

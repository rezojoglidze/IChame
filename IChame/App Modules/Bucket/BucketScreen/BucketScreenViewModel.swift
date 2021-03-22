//
//  BucketScreenViewModel.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/19/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator
import RxSwift
import RxCocoa

protocol BucketScreenViewModelProtocol {
    var router: StrongRouter<BucketRoute> { get }
    var bucketDidLoaded: Observable<Void> { get }

    func loadBucket(fail: @escaping Network.StatusBlock)
    
    func numberOfSections() -> Int
    
    func numberOfRows(section: Int) -> Int

    func item(at indexPath: IndexPath) -> MenuItem?
}

class BucketScreenViewModel {
    var router: StrongRouter<BucketRoute>
    var bucketService: BucketService?
    
    var bucketDidLoaded: Observable<Void>
    var innerBucketDidLoaded: PublishRelay<Void> = PublishRelay<Void>()
    private var bucket: Bucket?
    
    init(router: StrongRouter<BucketRoute>,
         bucketService: BucketService?) {
        self.router = router
        self.bucketDidLoaded = self.innerBucketDidLoaded.asObservable()
        self.bucketService = bucketService
    }
}

extension BucketScreenViewModel: BucketScreenViewModelProtocol {
    func numberOfRows(section: Int) -> Int {
        if section == 0 {
            return bucket?.numberOfRowsInSection(type: .hotDishes) ?? .zero
        } else if section == 1 {
            return bucket?.numberOfRowsInSection(type: .coldDishes) ?? .zero
        } else if section == 2 {
            return bucket?.numberOfRowsInSection(type: .drinks) ?? .zero
        } else {
            return bucket?.numberOfRowsInSection(type: .sauce) ?? .zero
        }
    }
    
    func numberOfSections() -> Int {
        return bucket?.numberOfSections ?? .zero
    }
    
    func item(at indexPath: IndexPath) -> MenuItem? {
        var type: MenuType = .coldDishes
        if indexPath.section == 0 {
            type = .hotDishes
        } else if indexPath.section == 1 {
            type = .coldDishes
        } else if indexPath.section == 2 {
            type = .drinks
        } else {
            type = .sauce
        }
        
        return bucket?.item(at: indexPath.row, type: type)
    }
    
    func loadBucket(fail: @escaping Network.StatusBlock) {
        let menuId = Menu.currentMenuId
        let userId = User.current?.uid ?? ""
        bucketService?.loadBucket(menuId, userId: userId, success: {[weak self] (bucket) in
            self?.bucket = bucket
            self?.innerBucketDidLoaded.accept(())
        }, fail: fail)
    }
}

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
    var showLoader: Observable<Bool> { get }
    
    func loadBucket(fail: @escaping Network.StatusBlock)
    
    func numberOfSections() -> Int
    
    func numberOfRowsInSection(section: Int) -> Int

    func item(at indexPath: IndexPath, with type: MenuType) -> MenuItem?
    
    func getSectionType(section: Int) -> MenuType
    
    func getTotalAmount() -> Double
    
    func removeDishFromBucket(with indexPath: IndexPath, type: MenuType, fail: @escaping Network.StatusBlock)
    
    func saveOrder(fail: @escaping Network.StatusBlock)
}

class BucketScreenViewModel {
    var router: StrongRouter<BucketRoute>
    var bucketService: BucketService?
    
    var bucketDidLoaded: Observable<Void>
    var showLoader: Observable<Bool>
    var innerBucketDidLoaded: PublishRelay<Void> = PublishRelay<Void>()
    var innerShowLoaderRelay: PublishRelay<Bool> = PublishRelay<Bool>()
    private var bucket: Bucket?
    private var sections: [MenuType] = []
    
    init(router: StrongRouter<BucketRoute>,
         bucketService: BucketService?) {
        self.router = router
        self.bucketDidLoaded = self.innerBucketDidLoaded.asObservable()
        self.showLoader = self.innerShowLoaderRelay.asObservable()
        self.bucketService = bucketService
    }
}

extension BucketScreenViewModel: BucketScreenViewModelProtocol {
    func removeDishFromBucket(with indexPath: IndexPath, type: MenuType, fail: @escaping Network.StatusBlock) {
        guard let menuItem = item(at: indexPath, with: type) else { return }
        
        bucketService?.removeDish(Menu.currentMenuId, with: menuItem, userId: User.current?.uid ?? "", success: {[weak self] (isRemoved) in
            
        }, fail: fail)
    }
    
    func saveOrder(fail: @escaping Network.StatusBlock) {
        innerShowLoaderRelay.accept(true)
        
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return bucket?.numberOfRowsInSection(type: sections[section]) ?? .zero
    }
    
    func numberOfSections() -> Int {
        return bucket?.numberOfSections ?? .zero
    }
    
    func item(at indexPath: IndexPath, with type: MenuType) -> MenuItem? {
        return bucket?.item(at: indexPath.row, type: type)
    }

    func getSectionType(section: Int) -> MenuType {
        if section < sections.count {
            return sections[section]
        }
        return .hotDishes
    }
    
    func getTotalAmount() -> Double {
        return bucket?.getTotalAmount ?? .zero
    }
    
    func loadBucket(fail: @escaping Network.StatusBlock) {
        let menuId = Menu.currentMenuId
        let userId = User.current?.uid ?? ""
        bucketService?.loadBucket(menuId, userId: userId, success: {[weak self] (bucket) in
            self?.bucket = bucket
            self?.sections = bucket?.sections ?? []
            self?.innerBucketDidLoaded.accept(())
        }, fail: fail)
    }
}

//
//  ScreenAssembly+Bucket.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/19/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import Swinject
import XCoordinator

extension ScreensAssembly {
    
    func setupBucket() {
        setupBucketScreen()
    }
    
    func setupBucketScreen() {
        self.container.register(BucketService.self) { (_) -> BucketService in
            return BucketService()
        }
        self.container.register(BucketScreenViewModel.self) { (resolver, router: StrongRouter<BucketRoute>) -> BucketScreenViewModel in
            let bucketService = resolver.resolve(BucketService.self)
            let viewModel = BucketScreenViewModel(router: router, bucketService: bucketService)
            return viewModel
        }
        
        self.container.register(BucketScreenViewController.self) { (resolver, router: StrongRouter<BucketRoute>) -> BucketScreenViewController in
            let viewController = BucketScreenViewController.loadFromStoryboard()
            let viewModel = resolver.resolve(BucketScreenViewModel.self, argument: router)
            viewController.viewModel = viewModel
            return viewController
        }
    }
}

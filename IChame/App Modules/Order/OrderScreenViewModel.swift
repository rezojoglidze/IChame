//
//  OrderViewModel.swift
//  IChame
//
//  Created by Rezo Joglidze on 4/10/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator
import RxSwift
import RxCocoa

protocol OrderScreenViewModelProtocol: class {
    var router: StrongRouter<OrderRoute> { get }
    var orderDidLoaded: Observable<Void> { get }

    func loadOrder(fail: @escaping Network.StatusBlock)
    
}

class OrderScreenViewModel {
    var router: StrongRouter<OrderRoute>
    var orderService: OrderService?

    var orderDidLoaded: Observable<Void>
    var innerOrderDidLoaded: PublishRelay<Void> = PublishRelay<Void>()
    
    init(router: StrongRouter<OrderRoute>,
         orderService: OrderService?) {
        self.router = router
        self.orderService = orderService
        self.orderDidLoaded = self.innerOrderDidLoaded.asObservable()
    }
}

extension OrderScreenViewModel: OrderScreenViewModelProtocol {
    func loadOrder(fail: @escaping Network.StatusBlock) {
        
    }
}

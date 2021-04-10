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
    var showLoader: Observable<Bool> { get }

    func loadOrder(fail: @escaping Network.StatusBlock)
    
}

class OrderScreenViewModel {
    var router: StrongRouter<OrderRoute>
    var orderService: OrderService?
    var orders: [Order] = []
    
    var orderDidLoaded: Observable<Void>
    var showLoader: Observable<Bool>
    var innerOrderDidLoaded: PublishRelay<Void> = PublishRelay<Void>()
    var innerShowLoader: PublishRelay<Bool> = PublishRelay<Bool>()

    init(router: StrongRouter<OrderRoute>,
         orderService: OrderService?) {
        self.router = router
        self.orderService = orderService
        self.orderDidLoaded = self.innerOrderDidLoaded.asObservable()
        self.showLoader = self.innerShowLoader.asObservable()
    }
}

extension OrderScreenViewModel: OrderScreenViewModelProtocol {
    func loadOrder(fail: @escaping Network.StatusBlock) {
        innerShowLoader.accept(true)
        orderService?.loadOrders(userId: User.current?.uid ?? "", success: {[weak self] (orders) in
            self?.orders = orders
            self?.innerOrderDidLoaded.accept(())
            self?.innerShowLoader.accept(false)
        }, fail: fail)
    }
}

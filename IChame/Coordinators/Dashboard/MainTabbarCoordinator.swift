//
//  MainTabbarCoordinator.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/18/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator

enum TabbarRoute: Route {
    case home
    case bucket
    case moreScreen
    case root
}

class MainTabbarCoordinator: TabBarCoordinator<TabbarRoute> {
    
    static var shared: MainTabbarCoordinator?
    
    private let menuRouter: StrongRouter<MenuRoute>
    private let bucketRouter: StrongRouter<BucketRoute>
    private let moreScreenRouter: StrongRouter<MoreSceenRoute>
    
    private let menu: MenuCoordinator
    private let bucket: BucketCoordinator
    private let moreScreen: MoreSceenCoordinator
    
    init(item: Menu?) {
        menu = MenuCoordinator(menu: item)
        bucket = BucketCoordinator()
        moreScreen = MoreSceenCoordinator()
        
        Self.initCoordinator(coordinator: menu, title: "მენიუ", image: "tab-icon-main")
        Self.initCoordinator(coordinator: bucket, title: "კალათა", image: "tab-icon-requests")
        Self.initCoordinator(coordinator: moreScreen, title: "მეტი", image: "more_icon")
        
        self.menuRouter = menu.strongRouter
        self.bucketRouter = bucket.strongRouter
        self.moreScreenRouter = moreScreen.strongRouter
        
        let tabs: [Presentable] = [menuRouter, bucketRouter, moreScreenRouter]
        
        super.init(rootViewController: IChameTabbarController(), tabs: tabs, select: menuRouter)
        MainTabbarCoordinator.shared = self
    }
    
    override func prepareTransition(for route: RouteType) -> TabBarTransition {
        switch route {
        case .home:
            return .select(menuRouter)
        case .bucket:
            return .select(bucketRouter)
        case .moreScreen:
            return .select(moreScreenRouter)
        case .root:
            if let window = UIApplication.shared.keyWindow {
                setRoot(for: window)
            }
            return .none()
        }
    }
}


extension MainTabbarCoordinator {
    
    static func initCoordinator(coordinator: Presentable, title: String = "", image: String) {
        let tabbarItem = initTabbarItem(title: title, image: image)
        (coordinator.viewController as? UINavigationController)?.tabBarItem = tabbarItem
    }
    
    static func initTabbarItem(title: String = "", image: String) -> UITabBarItem {
        let tabbarItem = UITabBarItem(title: title == "" ? nil : title, image: UIImage(named: image), selectedImage: UIImage(named: image))
        return tabbarItem
    }
}


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
  case root
}

class MainTabbarCoordinator: TabBarCoordinator<TabbarRoute> {
  
  static var shared: MainTabbarCoordinator?
  
  private let menuRouter: StrongRouter<MenuRoute>
  
  private let menu: MenuCoordinator
  
  init() {
    menu = MenuCoordinator()
    Self.initCoordinator(coordinator: menu, title: "მთავარი", image: "", selectedImage: "")
    
    self.menuRouter = menu.strongRouter
    
    let tabs: [Presentable] = [menuRouter]
    super.init(rootViewController: UITabBarController(), tabs: tabs, select: menuRouter)
    MainTabbarCoordinator.shared = self
  }
  
  override func prepareTransition(for route: RouteType) -> TabBarTransition {
    switch route {
    case .home:
      return .select(menuRouter)
    case .root:
      if let window = UIApplication.shared.keyWindow {
        setRoot(for: window)
      }
      return .none()
    }
  }
}


extension MainTabbarCoordinator {
  
  static func initCoordinator(coordinator: Presentable, title: String = "", image: String, selectedImage: String) {
    let tabbarItem = initTabbarItem(title: title, image: image, selectedImage: selectedImage)
    (coordinator.viewController as? UINavigationController)?.tabBarItem = tabbarItem
  }
  
  static func initTabbarItem(title: String = "", image: String, selectedImage: String) -> UITabBarItem {
    let tabbarItem = UITabBarItem(title: title == "" ? nil : title, image: UIImage(named: image), selectedImage: UIImage(named: selectedImage))
    tabbarItem.imageInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    return tabbarItem
  }
}


//
//  IChameTabbarController.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/18/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import UIKit

class IChameTabbarController: UITabBarController {
  private let foregroundColorKey = NSAttributedString.Key.foregroundColor
  private let fontKey = NSAttributedString.Key.font
  private let fontSize: CGFloat = 10// * Constants.ScreenFactor
  private let greenColor = #colorLiteral(red: 0.03529411765, green: 0.6941176471, blue: 0.5333333333, alpha: 1)
  private let blackColor = #colorLiteral(red: 0.1137254902, green: 0.1058823529, blue: 0.09411764706, alpha: 1)
  
  static var shared: IChameTabbarController? { get { return UIApplication.shared.keyWindow?.rootViewController as? IChameTabbarController } }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let font = UIFont(name: "HelveticaNeueLTGEO-55Roman", size: 15)
    
    self.tabBar.backgroundColor = UIColor.white

    if #available(iOS 13, *) {
      let appearance = UITabBarAppearance()
      appearance.stackedLayoutAppearance.normal.iconColor = blackColor
      appearance.stackedLayoutAppearance.normal.titleTextAttributes = [foregroundColorKey: blackColor, fontKey: font ?? ""]
      
      appearance.stackedLayoutAppearance.selected.iconColor = greenColor
      appearance.stackedLayoutAppearance.selected.titleTextAttributes = [foregroundColorKey: greenColor, fontKey: font ?? ""]
      
      appearance.stackedItemPositioning = .fill
      tabBar.standardAppearance = appearance
    } else {
      let appearance = UITabBarItem.appearance(whenContainedInInstancesOf: [IChameTabbarController.self])
      appearance.setTitleTextAttributes([foregroundColorKey: blackColor, fontKey: font ?? ""], for: .normal)
      appearance.setTitleTextAttributes([foregroundColorKey: greenColor, fontKey: font ?? ""], for: .selected)
      UITabBar.appearance().tintColor = greenColor
      tabBar.unselectedItemTintColor = blackColor
    }
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    layoutTabTitles()
  }
  
  func layoutTabTitles() {
    if let tabbarItems = self.tabBar.items {
      for item in tabbarItems {
        item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -10)
      }
    }
  }
  
//  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//    if item.title == LocalString("Products") {
//      NotificationCenter.default.post(name: .tabReselected, object: nil)
//    } else if item.title == LocalString("Main") {
//      NotificationCenter.default.post(name: .homeReselected, object: nil)
//    }
//  }
}

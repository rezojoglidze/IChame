//
//  MoreScreenViewController.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/19/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit
import XCoordinator

class MoreScreenViewController: UIViewController {
  
  var viewModel: MoreScreenViewModelProtocol!
  
  static func instantiate(strongRouter: StrongRouter<MoreSceenRoute>) -> Self {
    let viewController = ScreensAssembly.shared.container.resolve(Self.self, argument: strongRouter) ?? .init()
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.isNavigationBarHidden = true
  }
}

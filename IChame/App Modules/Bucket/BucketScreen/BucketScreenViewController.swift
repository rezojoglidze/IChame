//
//  BucketScreenViewController.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/19/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit
import XCoordinator

class BucketScreenViewController: UIViewController {
  
  var viewModel: BucketScreenViewModelProtocol!
  
  static func instantiate(strongRouter: StrongRouter<BucketRoute>) -> Self {
    let viewController = ScreensAssembly.shared.container.resolve(Self.self, argument: strongRouter) ?? .init()
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.isNavigationBarHidden = true
  }
}

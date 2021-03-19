//
//  HomeScreenViewController.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/18/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit
import XCoordinator

class MenuScreenViewController: UIViewController {
    
    var viewModel: MenuScreenViewModelProtocol!
    
    static func instantiate(strongRouter: StrongRouter<MenuRoute>) -> Self {
        let viewController = ScreensAssembly.shared.container.resolve(Self.self, argument: strongRouter) ?? .init()
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
    }
}

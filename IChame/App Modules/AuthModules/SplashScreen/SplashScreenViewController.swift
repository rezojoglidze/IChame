//
//  SplashScreenView.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/10/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit
import XCoordinator

class SplashScreenViewController: UIViewController {
    
    var viewModel: SplashScreenViewModelProtocol!
    
    static func instantiate(unownedRouter: UnownedRouter<MainRoute>) -> Self {
        let viewController = ScreensAssembly.shared.container.resolve(Self.self, argument: unownedRouter) ?? .init()
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.viewModel.triggerSplashScreenCompletion()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}

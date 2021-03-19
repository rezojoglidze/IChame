//
//  MenuDetailsScreenViewController.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/19/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit
import XCoordinator

class MenuDetailsScreenViewController: UIViewController {

    var viewModel: MenuDetailsScreenViewModel!
    
    static func instantiate(strongRouter: StrongRouter<MenuRoute>, menuItems: [MenuItem]) -> Self {
        let viewController = ScreensAssembly.shared.container.resolve(Self.self, arguments: strongRouter, menuItems) ?? .init()
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "დეტალები"
        navigationItem.largeTitleDisplayMode = .never
    }
}

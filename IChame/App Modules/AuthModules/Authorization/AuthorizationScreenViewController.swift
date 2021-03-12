//
//  AuthorizationScreenViewController.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/11/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit
import XCoordinator

class AuthorizationScreenViewController: UIViewController {
  
  var viewModel: AuthorizationScreenViewModelProtocol!
  @IBOutlet weak var loginBtn: UIButton!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  static func instantiate(unownedRouter: UnownedRouter<AuthRoute>) -> Self {
    let viewController = ScreensAssembly.shared.container.resolve(Self.self, argument: unownedRouter) ?? .init()
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loginBtn.setTitle("შესვლა".uppercased(), for: .normal)
    navigationController?.isNavigationBarHidden = true
  }
  
  @IBAction func acountHaveNotBtnTapped(_ sender: Any) {
    viewModel.acountHaveNotBtnTapped()
  }
}

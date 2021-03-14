//
//  AuthorizationScreenViewController.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/11/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit
import XCoordinator
import RxSwift

class AuthorizationScreenViewController: UIViewController {
  
  var viewModel: AuthorizationScreenViewModelProtocol!
  @IBOutlet private weak var loginBtn: UIButton!
  @IBOutlet private weak var emailTextField: UITextField!
  @IBOutlet private weak var passwordTextField: UITextField!
  
  private var disposeBag = DisposeBag()

  static func instantiate(unownedRouter: UnownedRouter<AuthRoute>) -> Self {
    let viewController = ScreensAssembly.shared.container.resolve(Self.self, argument: unownedRouter) ?? .init()
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loginBtn.setTitle("შესვლა".uppercased(), for: .normal)
    self.hideKeyboardWhenTappedOutside()
    setupObservables()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = true
  }
  
  func setupObservables() {
    viewModel.userDidLogin.subscribe(onNext: { [weak self] in
      self?.stopLoader()
      self?.viewModel.triggerAuthorizationCompletion()
    }).disposed(by: disposeBag)
  }
  
  func checkValidation() {
    if emailTextField.string.isEmpty || passwordTextField.string.isEmpty {
      showAlert(text: "გთხოვთ, შეავსოთ სავალდებულო ველები.")
      return
    }
    self.startLoader()
    viewModel.authorization(email: emailTextField.string, password: passwordTextField.string, fail: self.standardFailBlock)
  }
  
  @IBAction func loginBtnTapped(_ sender: Any) {
    checkValidation()
  }
  
  @IBAction func acountHaveNotBtnTapped(_ sender: Any) {
    viewModel.acountHaveNotBtnTapped()
  }
}

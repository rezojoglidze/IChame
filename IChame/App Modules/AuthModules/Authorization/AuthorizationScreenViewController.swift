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
  @IBOutlet private weak var scrollView: UIScrollView!
  
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
    setupKeyboardObservers()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    removeKeyboardObservers()
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
  
  private func setupKeyboardObservers() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
  }
  
  @objc private func adjustForKeyboard(notification: Notification) {
    guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
    
    let keyboardScreenEndFrame = keyboardValue.cgRectValue
    let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
    
    if notification.name == UIResponder.keyboardWillHideNotification {
      scrollView.contentInset = .zero
    } else {
      scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
    }
    
    scrollView.scrollIndicatorInsets = scrollView.contentInset
  }
  
  private func removeKeyboardObservers() {
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @IBAction func loginBtnTapped(_ sender: Any) {
    checkValidation()
  }
  
  @IBAction func acountHaveNotBtnTapped(_ sender: Any) {
    viewModel.acountHaveNotBtnTapped()
  }
}

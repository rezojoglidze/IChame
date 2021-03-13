//
//  RegistrationScreenViewController.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/12/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit
import XCoordinator
import RxSwift

class RegistrationScreenViewController: UIViewController {
  
  var viewModel: RegistrationScreenViewModelDelegate!
  
  @IBOutlet private weak var nameTextField: UITextField!
  @IBOutlet private weak var emailTextField: UITextField!
  @IBOutlet private weak var passwordTextField: UITextField!
  @IBOutlet private weak var repeatPasswordTextField: UITextField!
  @IBOutlet private weak var registrationBtn: UIButton!
  
  private var disposeBag = DisposeBag()
  
  static func instantiate(unownedRouter: UnownedRouter<AuthRoute>) -> Self {
    let viewController = ScreensAssembly.shared.container.resolve(Self.self, argument: unownedRouter) ?? .init()
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    registrationBtn.setTitle("რეგისტრაცია".uppercased(), for: .normal)
    self.hideKeyboardWhenTappedOutside()
    setupObservables()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = false
  }
  
  private func setupObservables() {
    viewModel.userDidRegister.subscribe(onNext: { [weak self] in
      self?.stopLoader()
      self?.resetTextFields()
    }).disposed(by: disposeBag)
  }
  
  private func resetTextFields() {
    [nameTextField,emailTextField,passwordTextField,repeatPasswordTextField].forEach { (textField) in
      textField?.text = ""
    }
    showAlert(text: "თქვენ წარმატებით დარეგისტრირდით!")
  }
  
  private func checkValidation() {
    if nameTextField.string.isEmpty || emailTextField.string.isEmpty ||
        passwordTextField.string.isEmpty || repeatPasswordTextField.string.isEmpty {
      showAlert(text: "გთხოვთ, შეავსოთ ყველა სავალდებულო ველი.")
      return
    }
    if passwordTextField.string != repeatPasswordTextField.string {
      showAlert(text: "პაროლები ერთმანეთს არ ემთხვევა")
      return
    }
    self.startLoader()
    viewModel.registration(email: emailTextField.string, password: passwordTextField.string, fail: self.standardFailBlock)
  }
  
  @IBAction func registrationBtnTapped(_ sender: Any) {
    checkValidation()
  }
  
  @IBAction func alreadyHaveAnAccount(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
}

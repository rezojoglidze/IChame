//
//  RegistrationScreenViewController.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/12/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import XCoordinator

class RegistrationScreenViewController: UIViewController {

  var viewModel: RegistrationScreenViewModelDelegate!
  
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var repeatPasswordTextField: UITextField!
  @IBOutlet weak var registrationBtn: UIButton!
  
  static func instantiate(unownedRouter: UnownedRouter<AuthRoute>) -> Self {
    let viewController = ScreensAssembly.shared.container.resolve(Self.self, argument: unownedRouter) ?? .init()
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.isNavigationBarHidden = false
    registrationBtn.setTitle("რეგისტრაცია".uppercased(), for: .normal)
    self.hideKeyboardWhenTappedOutside()
  }
  
  @IBAction func registrationBtnTapped(_ sender: Any) {
    Auth.auth().createUser(withEmail: emailTextField.text ?? "default", password: passwordTextField.text ?? "default") { [weak self] (authResult, error) in
      guard let user = authResult?.user, error == nil else {
        print("error", error ?? "dd")
        return
      }
      print("user -> ", user.email!," created")
    }
  }
  
  @IBAction func alreadyHaveAnAccount(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
}

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
    @IBOutlet private weak var scrollView: UIScrollView!
    
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
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardObservers()
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

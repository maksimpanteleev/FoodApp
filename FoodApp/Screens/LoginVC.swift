//
//  LoginVC.swift
//  FoodApp
//
//  Created by maxim panteleev on 19.06.2021.
//

import UIKit
import WebKit

class LoginVC: UIViewController {
    
    let loginTextField = FTextField(placeholder: "Enter a login", isSecure: false)
    let passwordTextField = FTextField(placeholder: "Enter a password", isSecure: true)
    let signInButton = FButton(title: "Sign In")
    let registerButton = FButton(title: "Register")
    let webView = WKWebView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.delegate = self
        passwordTextField.delegate = self
        view.addSubviews(loginTextField, passwordTextField, signInButton, registerButton, webView)
        configureUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        loginTextField.text = ""
        passwordTextField.text = ""
    }
    
    
    //MARK: - UI configuration
    private func configureUI() {
        view.backgroundColor = UIColor(named: "background_color")
        configureWebView()
        configureSignInButtonAction()
        configureRegisterButtonAction()
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 250),
            
            loginTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 2),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            loginTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 25),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 25),
            signInButton.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 40),
            signInButton.widthAnchor.constraint(equalToConstant: 100),
            
            registerButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 25),
            registerButton.centerXAnchor.constraint(equalTo: signInButton.centerXAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 40),
            registerButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func configureWebView() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        let url = URL(string: "https://i.pinimg.com/originals/72/9b/17/729b174fb8d50fce2c76e2dcc4aa14e4.gif")
        var urlRequest = URLRequest(url: url!)
        urlRequest.cachePolicy = .returnCacheDataElseLoad
        webView.load(urlRequest)
        webView.backgroundColor = .clear
        webView.alpha = 0

        UIView.animate(withDuration: 5, delay: 2) {
            self.webView.alpha = 1
        }
    }
    
    
    //MARK: - Sign In button action configuration
    private func configureSignInButtonAction() {
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    }
    
    @objc func signInButtonTapped() {
        guard let email = loginTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else {
            presentAlertVC(title: "Invalid input", message: "Please enter login and password.")
            return
        }
        AuthenticationManager.updateUsersStatus(login: email, password: password, actionType: .signIn) { [unowned self] error in
            if let error = error {
                guard let errorMessage = AuthenticationManager.firebaseError else { return }
                self.presentAlertVC(title: "Error", message: error == .firebaseErrors ? errorMessage : error.rawValue)
            } else {
                let rootVC = ContainerVC()
                let navigationController = UINavigationController(rootViewController: rootVC)
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true, completion: nil)
            }
        }
    }
    
    
    //MARK: - Register button action configuration
    private func configureRegisterButtonAction() {
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    @objc func registerButtonTapped() {
        guard let email = loginTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else {
            presentAlertVC(title: "Invalid input", message: "Please enter login and password.")
            return
        }
        AuthenticationManager.updateUsersStatus(login: email, password: password, actionType: .signUp) { [unowned self] error in
            if let error = error {
                guard let errorMessage = AuthenticationManager.firebaseError else { return }
                self.presentAlertVC(title: "Error", message: error == .firebaseErrors ? errorMessage : error.rawValue)
            } else {
                self.presentAlertVC(title: "Success", message: "Successfully registered")
            }
        }
    }
    
    
    //MARK: - Methods to hide the keyboard
    // Hides keyboard after user tapped on view's background
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        self.view.endEditing(true)
    }
}

extension LoginVC: UITextFieldDelegate {
    // Hides keyboard after pressing enter button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

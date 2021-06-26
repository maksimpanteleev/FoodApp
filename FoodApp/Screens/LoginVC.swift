//
//  LoginVC.swift
//  FoodApp
//
//  Created by maxim panteleev on 19.06.2021.
//

import UIKit

class LoginVC: UIViewController {
    
    let loginTextField = FTextField(placeholder: "Enter a login", isSecure: false)
    let passwordTextField = FTextField(placeholder: "Enter a password", isSecure: true)
    let signInButton = FButton(title: "Sign In")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(loginTextField, passwordTextField, signInButton)
        configureUI()
    }
    
    
    //MARK: - UI configuration
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureSignInButtonAction()
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
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
            signInButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    
    //MARK: - Sign In button action configuration
    private func configureSignInButtonAction() {
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    }
    
    @objc func signInButtonTapped() {
        let rootVC = ContainerVC()
        let navigationController = UINavigationController(rootViewController: rootVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
}


//
//  FAlertVC.swift
//  FoodApp
//
//  Created by maxim panteleev on 27.06.2021.
//

import UIKit

class FAlertVC: UIViewController {
    
    let containerView = FAlertContainerView()
    let button = FButton(title: "Ok")
    let titleLabel = FLabel(fontSize: 20, weight: .heavy, alignment: .center)
    let bodyLabel = FLabel(fontSize: 16, weight: .regular, alignment: .center)
    
    var alertTitle: String?
    var message: String?
    let padding: CGFloat = 10
    
    init(title: String, message: String) {
        super.init(nibName: nil, bundle: nil)
        alertTitle = title
        self.message = message
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray.withAlphaComponent(0.75)
        configureContainer()
        configureTitleLabel()
        configureBodyLabel()
        configureButton()
    }
    
    private func configureContainer() {
        view.addSubview(containerView)
        containerView.addSubviews(button, bodyLabel, titleLabel)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 240),
            containerView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureTitleLabel() {
        titleLabel.text = alertTitle
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    private func configureBodyLabel() {
        bodyLabel.text = message
        bodyLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: padding),
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            bodyLabel.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -padding)
        ])
    }
    
    private func configureButton() {
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            button.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    @objc func buttonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

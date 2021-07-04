//
//  ContainerVC.swift
//  FoodApp
//
//  Created by maxim panteleev on 26.06.2021.
//

import UIKit

class ContainerVC: UIViewController {
    
    let fTabBarController = FTabBarController()
    let menuVC = MenuVC()
    var isMenuOpened = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureOriginalState()
    }
    
    private func configureNavigationBar() {
        navigationController?.setToolbarHidden(true, animated: true)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-menu-50"), style: .plain, target: self, action: #selector(menuButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: .done, target: self, action: #selector(signOutButtonTapped))
    }
    
    private func configureOriginalState() {
        view.addSubview(fTabBarController.view)
        menuVC.delegate = self
        view.insertSubview(menuVC.view, at: 0)
        addChild(fTabBarController)
        addChild(menuVC)
    }

    @objc func signOutButtonTapped() {
        AuthenticationManager.updateUsersStatus(login: "", password: "", actionType: .singOut) { error in
            guard error == nil else {
                self.presentAlertVC(title: "Error", message: AuthenticationManager.firebaseError ?? "Unexpected error." )
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func menuButtonTapped() {
        showMenu()
    }
    
    func showMenu() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut) {
            self.fTabBarController.view.frame.origin.x = self.isMenuOpened ? 0 : self.fTabBarController.view.frame.width - 140
            self.menuVC.view.alpha = !self.isMenuOpened ? 1 : 0
        }
        isMenuOpened.toggle()
        
    }
}

extension ContainerVC: MenuVCDelegate {
    
    // show user's profile
    func profileButtonItemTapped() {
        guard let user = AuthenticationManager.user else { return }
        print("Username = \(String(describing: user.displayName))\nUserId = \(user.uid)\nUserEmail = \(user.email!)")
    }
    
    // show Search screen
    func searchButtonItemTapped() {
        fTabBarController.presentVC(viewController: .SearchVC)
    }
    
    // show Favorites screen
    func favoritesButtonItemTapped() {
        fTabBarController.presentVC(viewController: .FavoritesVC)
    }
}

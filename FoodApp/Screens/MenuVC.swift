//
//  MenuVC.swift
//  FoodApp
//
//  Created by maxim panteleev on 26.06.2021.
//

import UIKit

protocol MenuVCDelegate: AnyObject {
    func searchButtonItemTapped()
    func favoritesButtonItemTapped()
    func profileButtonItemTapped()
}

enum Menu: Int {
    
    case profile
    case search
    case favorites
    case signOut
    
    var description: String {
        switch self {
        case .profile: return "User's profile"
        case .search: return "Search for a recipe"
        case .favorites: return "Favorite meals"
        case .signOut: return "Sign out"
        }
    }
}

class MenuVC: UIViewController {
    
    var tableView = UITableView()
    weak var delegate: MenuVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.frame = view.bounds
        tableView.backgroundColor = .systemGray2
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView(frame: .zero)
        
        tableView.register(MenuTableCell.self, forCellReuseIdentifier: MenuTableCell.reuseId)
    }
}

extension MenuVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableCell.reuseId, for: indexPath) as! MenuTableCell
        cell.textLabel?.text = Menu(rawValue: indexPath.row)?.description
        return cell
    }
}

extension MenuVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuItem = Menu(rawValue: indexPath.row), let delegate = delegate else { return }
        
        switch menuItem {
        case .profile:
            delegate.profileButtonItemTapped()
        case .search:
            delegate.searchButtonItemTapped()
        case .favorites:
            delegate.favoritesButtonItemTapped()
        case .signOut:
            AuthenticationManager.updateUsersStatus(login: "", password: "", actionType: .singOut) { error in
                guard error == nil else {
                    self.presentAlertVC(title: "Error", message: AuthenticationManager.firebaseError!)
                    return
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

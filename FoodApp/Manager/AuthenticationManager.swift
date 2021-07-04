//
//  AuthenticationManager.swift
//  FoodApp
//
//  Created by maxim panteleev on 28.06.2021.
//

import Foundation
import Firebase

enum AuthType {
    case signIn, signUp, singOut
}

enum AuthenticationManager {
    
    static var user: User?
    static var firebaseError: String?
    
    static func updateUsersStatus(login: String, password: String, actionType: AuthType, completed: @escaping (FError?) -> Void) {
        switch actionType {
        case .signIn:
            signIn(login: login, password: password) { result in
                switch result {
                case .success(let user):
                    self.user = user
                    print(user.uid)
                    completed(nil)
                case .failure(let error):
                    completed(error)
                }
            }
        case .signUp:
            signUp(login: login, password: password) { result in
                switch result {
                case .success(_):
                    completed(nil)
                case .failure(let error):
                    completed(error)
                }
            }
        case .singOut:
            guard let user = self.user else {
                completed(.invalidUser)
                return
            }
            signOut(user: user) { result in
                switch result {
                case .success(_):
                    self.user = nil
                    completed(nil)
                case .failure(let error):
                    completed(error)
                }
            }
        }
    }
    
    
    static private func signIn(login: String, password: String, completed: @escaping (Result<User, FError>) -> Void) {
        Auth.auth().signIn(withEmail: login, password: password) { result, error in
            guard let user = result?.user, error == nil else {
                firebaseError = error!.localizedDescription
                completed(.failure(.firebaseErrors))
                return
            }
            completed(.success(user))
        }
    }
    
    static private func signUp(login: String, password: String, completed: @escaping (Result<User, FError>) -> Void) {
        Auth.auth().createUser(withEmail: login, password: password) { result, error in
            guard let user = result?.user, error == nil else {
                firebaseError = error!.localizedDescription
                completed(.failure(.firebaseErrors))
                return
            }
            completed(.success(user))
        }
    }
    
    static private func signOut(user: User, completed: @escaping (Result<User, FError>) -> Void) {
        do {
            try Auth.auth().signOut()
            completed(.success(user))
        } catch let error{
            firebaseError = error.localizedDescription
            completed(.failure(.firebaseErrors))
        }
    }
}

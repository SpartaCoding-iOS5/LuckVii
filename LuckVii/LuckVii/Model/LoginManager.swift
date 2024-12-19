//
//  LoginManager.swift
//  LuckVii
//
//  Created by 박진홍 on 12/19/24.
//

import UIKit

final class LoginManager {
    static let shared: LoginManager = LoginManager(userDefaults: UserDefaults.standard)
    
    private init (userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    private let userDefaults: UserDefaults
    private let loginKey: String = "isUserLoggedIn"
    
    var isUserLoggedIn: Bool {
        userDefaults.bool(forKey: loginKey)
    }
    
    func presentLoginModal(viewController: UIViewController) {
        let modalLoginVC: LoginViewController = LoginViewController()
        viewController.present(modalLoginVC, animated: true, completion: nil)
    }
}

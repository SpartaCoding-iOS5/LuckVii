//
//  LoginManager.swift
//  LuckVii
//
//  Created by 박진홍 on 12/19/24.
//

import UIKit

final class LoginManager {
    static let shared: LoginManager = LoginManager()
    
    private init () {}
    
    func presentLoginModal(viewController: UIViewController) {
        let modalLoginVC: LoginViewController = LoginViewController()
        viewController.present(modalLoginVC, animated: true, completion: nil)
    }
}

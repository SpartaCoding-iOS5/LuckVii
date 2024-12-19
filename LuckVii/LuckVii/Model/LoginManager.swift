//
//  LoginManager.swift
//  LuckVii
//
//  Created by 박진홍 on 12/19/24.
//

import UIKit

final class LoginManager {
    private let userDefaultsManager: UserDefaultsManager

    init(userDefaultsManager: UserDefaultsManager) {
        self.userDefaultsManager = userDefaultsManager
    }

    var isUserLoggedIn: Bool {
        return userDefaultsManager.getLoggedInStatus()
    }

    // MARK: - 유저 디폴츠로 로그인 여부 확인 후 모달 띄우기

    func ensurePresentLoginModal(viewController: UIViewController) {
        if !isUserLoggedIn {
            presentLoginModal(viewController: viewController)
        }
    }

    private func presentLoginModal(viewController: UIViewController) {
        let modalLoginVC: LoginViewController = LoginViewController()
        viewController.present(modalLoginVC, animated: true, completion: nil)
    }
}

//
//  UserDefaultsManger.swift
//  LuckVii
//
//  Created by 박진홍 on 12/20/24.
//

import Foundation

final class UserDefaultsManager {
    static let shared: UserDefaultsManager = UserDefaultsManager(userDefaults: UserDefaults.standard)

    private init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    private let userDefaults: UserDefaults

    private enum Keys { // 하드코딩을 방지하고 자동완성 등으로 빠른 코딩 지원하기 위해 enum으로 묶음
        static let isUserLoggedIn = "isUserLoggedIn"
        static let userId = "userId"
        static let userPw = "userPw"
    }

    // MARK: - 로그인 상태 get / set

    func setLoggedInStatus(_ bool: Bool) {
        userDefaults.set(bool, forKey: Keys.isUserLoggedIn)
    }

    func getLoggedInStatus() -> Bool {
        return userDefaults.bool(forKey: Keys.isUserLoggedIn)
    }

    // MARK: - id, pw get / set

    func setUserId(_ id: String) {
        userDefaults.set(id, forKey: Keys.userId)
    }

    func setUserPw(_ password: String) {
        userDefaults.set(password, forKey: Keys.userPw)
    }

    // 저장 된 유저 디폴츠 값이 없다면 빈 문자열을 반환하여 비어보이게 처리.
    func getUserId() -> String {
        guard let id = userDefaults.string(forKey: Keys.userId) else {
            return ""
        }

        return id
    }

    func getUserPw() -> String {
        guard let password = userDefaults.string(forKey: Keys.userPw) else {
            return ""
        }

        return password
    }

}

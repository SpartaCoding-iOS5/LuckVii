//
//  LoginViewController.swift
//  LuckVii
//
//  Created by jae hoon lee on 12/17/24.
//

import UIKit
import SnapKit

final class LoginViewController: UIViewController {

    private let loginView = LoginView()

    // 다시 로그인 화면으로 왔을 시 초기화
    override func viewWillAppear(_ animated: Bool) {
        setupUI()

        loginView.emailTextField.text = UserDefaultsManager.shared.getUserId()
        loginView.pwTextField.text = UserDefaultsManager.shared.getUserPw()
        loginView.checkLoginInfo.text = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAction()
        textFieldSetup()
    }

    // 화면 터치시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(loginView)

        loginView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Connect Button Part

extension LoginViewController {

    // 버튼 동작 연결 및 동작 설정
    private func setupAction() {

        // 로그인 버튼 연결
        loginView.loginButton.addAction(UIAction { [weak self] _ in
            self?.tappedLoginButton()
        }, for: .touchUpInside)

        // 회원가입 버튼 연결
        loginView.signUpButton.addAction(UIAction { [weak self] _ in
            self?.tappedSignUpButton()
        }, for: .touchUpInside)

        // 비회원 버튼 연결
        loginView.noMemberButton.addAction(UIAction { [weak self] _ in
            self?.tappedNoMemberButton()
        }, for: .touchUpInside)
    }
}

// MARK: - Button Action Part

extension LoginViewController {

    // 로그인 버튼 누를 시
    private func tappedLoginButton() {
        var emailInfo: String?
        var pwInfo: String?

        // 1. 아이디와 비밀번호가 입력이 되었는지 확인
        if loginView.emailTextField.text == "" {
            loginView.checkLoginInfo.text = "아이디를 입력해주세요"
            return
        } else if loginView.pwTextField.text == "" {
            loginView.checkLoginInfo.text = "비밀번호를 입력해주세요"
            return
        }

        // 2. 두개의 값을 변수에 저장 후
        emailInfo = loginView.emailTextField.text
        pwInfo = loginView.pwTextField.text

        // 3. 맞으면 다음 화면, 틀리면 다시 값을 입력
        if emailInfo != "" && pwInfo != "" {
            guard let id = emailInfo, let password = pwInfo else { return }

            if checkUserInfo(id, password) {
//                UserDefaultsManager.shared.setLoggedInStatus(true)
                UserDefaultsManager.shared.setUserId(id)
                UserDefaultsManager.shared.setUserPw(password)
                self.dismiss(animated: true)
            } else {
                loginView.checkLoginInfo.text = "비밀번호가 올바르지 않습니다."
                loginView.pwTextField.text = ""
            }
        }
    }

    // 유저 정보를 확인하는 메서드
    private func checkUserInfo(_ id: String, _ password: String) -> Bool {
        UserDataManger.shared.checkUser(id, password)
    }

    // 회원가입 버튼 누를 시(회원가입화면으로)
    private func tappedSignUpButton() {
        let signUpVC = SignUpViewController()
        self.present(signUpVC, animated: true, completion: nil)
    }

    // 비회원 버튼 누를 시(메인화면으로)
    private func tappedNoMemberButton() {
        self.dismiss(animated: true)

    }
}

// MARK: - TextField Part

extension LoginViewController: UITextFieldDelegate {

    // 텍스트필드 관련 setting
    private func textFieldSetup() {
        loginView.emailTextField.delegate = self
        loginView.pwTextField.delegate = self

        loginView.emailTextField.returnKeyType = .done
        loginView.pwTextField.returnKeyType = .done
    }

    // 텍스트필드 간의 이동과 키보드 관련 메서드
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 두개의 텍스트필드를 모두 종료 (키보드 내리기)
        if loginView.emailTextField.text != "", loginView.pwTextField.text != "" {
            loginView.pwTextField.resignFirstResponder()
            return true
            // 두번째 텍스트필드로 이동
        } else if loginView.emailTextField.text != "" {
            loginView.pwTextField.becomeFirstResponder()
            return true
        }
        return false
    }
}

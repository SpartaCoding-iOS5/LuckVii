//
//  SignUpViewController.swift
//  LuckVii
//
//  Created by jae hoon lee on 12/17/24.
//
import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
    private let signUpView = SignUpView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        applyAction()
        textFieldSetup()
    }
    
    // 화면 터치시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setupUI() {
        view.addSubview(signUpView)
        
        signUpView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - action Part

extension SignUpViewController {
    
    private func applyAction() {
        signUpView.duplicateCheckButton.addAction(UIAction { [weak self] _ in
            self?.tappedCheckDuplicateButton()
        }, for: .touchUpInside)
        
        signUpView.signUpButton.addAction(UIAction { [weak self] _ in
            self?.tappedSignUpButton()
        }, for: .touchUpInside)
    }
    
    private func tappedCheckDuplicateButton() {
        guard let emailText = signUpView.emailTextField.text else { return }
        if emailText.isEmpty {
            signUpView.checkEmailLabel.text = "이메일을 입력해주세요."
        } else {
            signUpView.checkEmailLabel.text = "중복된 아이디입니다."
        }
        checkPassword()
    }
    
    private func tappedSignUpButton() {
        createUserInfo()
    }
        
}

// MARK: - method Part

extension SignUpViewController {
    
    func checkPassword() {
        if signUpView.pwTextField.text == signUpView.pwCheckTextField.text {
            signUpView.checkPwLabel.text = ""
        } else {
            signUpView.checkPwLabel.text = "비밀번호가 동일하지 않습니다."
        }
        
        checkDuplicateEmail()
    }
    
    func createUserInfo() {
        print("email : \(signUpView.emailTextField.text ?? "nil")")
        guard let email = signUpView.emailTextField.text,
              let password = signUpView.pwTextField.text,
              let name = signUpView.nameTextField.text,
              let birth = signUpView.birthTextField.text,
              let phoneNumber = signUpView.phoneNumberTextField.text
        else {
            print("모든 데이터를 입력해야합니다")
            return
        }
        
        let userInfo = UserInfoData.init(email: email, password: password, name: name, birth: birth, phoneNumber: phoneNumber)
        UserDataManger.shared.createUserData(userInfo)
    }
    
    func checkDuplicateEmail() {
        readUserInfo()
    }
    
    func readUserInfo() {
        let users = UserDataManger.shared.getUserInfos()
        for user in users {
            print("User: \(user.email), \(user.password), \(user.name), \(user.birth), \(user.phoneNumber)")
        }
    }
}

// MARK: - textField Part

extension SignUpViewController: UITextFieldDelegate {
    
    private func textFieldSetup() {
        signUpView.emailTextField.delegate = self
        signUpView.pwTextField.delegate = self
        signUpView.pwCheckTextField.delegate = self
        signUpView.nameTextField.delegate = self
        signUpView.birthTextField.delegate = self
        signUpView.phoneNumberTextField.delegate = self
    }
}

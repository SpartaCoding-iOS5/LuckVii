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
    
    // 버튼에 액션 연결
    private func applyAction() {
        
        // 중복확인 버튼 연결
        signUpView.duplicateCheckButton.addAction(UIAction { [weak self] _ in
            self?.tappedCheckDuplicateButton()
        }, for: .touchUpInside)
        
        // 회원가입 버튼 연결
        signUpView.signUpButton.addAction(UIAction { [weak self] _ in
            self?.tappedSignUpButton()
        }, for: .touchUpInside)
    }
    
    
    // 중복확인 버튼 동작
    private func tappedCheckDuplicateButton() {
        // 1. 이메일 입력값 가져오기
        guard let emailText = signUpView.emailTextField.text, !emailText.isEmpty else {
            signUpView.checkEmailLabel.textColor = .red
            signUpView.checkEmailLabel.text = "이메일을 입력해주세요."
            return
        }
        
        // 2. 저장된 데이터 이메일과 중복 비교
        if UserDataManger.shared.checkEmail(emailText) {
            signUpView.checkEmailLabel.textColor = .red
            signUpView.checkEmailLabel.text = "중복된 이메일입니다."
        } else {
            signUpView.checkEmailLabel.textColor = .green
            signUpView.checkEmailLabel.text = "사용 가능한 이메일입니다."
        }
    }
    
    private func tappedSignUpButton() {
        createUserInfo()
    }
        
}

// MARK: - method Part

extension SignUpViewController {
    
    
    
    // 유저 데이터 생성
    func createUserInfo() {
        guard let email = signUpView.emailTextField.text,
              let password = signUpView.pwTextField.text,
              let name = signUpView.nameTextField.text,
              let birth = signUpView.birthTextField.text,
              let phoneNumber = signUpView.phoneNumberTextField.text
        else {
            print("모든 데이터를 입력해야합니다")
            return
        }
        
        // 텍스트필드 값을 UserInfoData에 추가 후 생성
        let userInfo = UserInfoData.init(email: email, password: password, name: name, birth: birth, phoneNumber: phoneNumber)
        UserDataManger.shared.createUserData(userInfo)
    }
    
    // 이메일 중복 확인
    func checkDuplicateEmail() {
        readUserInfo()
    }
    
    // 저장된 유저 정보를 읽기
    func readUserInfo() {
        let users = UserDataManger.shared.getUserInfos()
        for user in users {
            print("User: \(user.email), \(user.password), \(user.name), \(user.birth), \(user.phoneNumber)")
        }
    }
}

// MARK: - textField Part

extension SignUpViewController: UITextFieldDelegate {
    
    // 텍스트필드 setting
    private func textFieldSetup() {
        signUpView.emailTextField.delegate = self
        signUpView.pwTextField.delegate = self
        signUpView.pwCheckTextField.delegate = self
        signUpView.nameTextField.delegate = self
        signUpView.birthTextField.delegate = self
        signUpView.phoneNumberTextField.delegate = self
    }
    
    // 비밀번호 확인 텍스트필드 입력 마쳤을 때 함수 호출
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == signUpView.pwCheckTextField {
            checkPassword()
        }
    }
    
    // 입력한 비밀번호가 일치하는지 확인
    func checkPassword() {
        if signUpView.pwTextField.text == signUpView.pwCheckTextField.text {
            signUpView.checkPwLabel.textColor = .green
            signUpView.checkPwLabel.text = "비밀번호가 일치합니다."
        } else {
            signUpView.checkPwLabel.textColor = .red
            signUpView.checkPwLabel.text = "비밀번호가 동일하지 않습니다."
        }
    }
}

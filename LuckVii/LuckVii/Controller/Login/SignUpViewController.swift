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
    
    private func setupUI() {
        navigationItem.title = "회원가입"
        
        view.addSubview(signUpView)
        
        signUpView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Connect Button Part

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
            self?.dismiss(animated: true)
        }, for: .touchUpInside)
    }
}

// MARK: - Button Action Part

extension SignUpViewController {
    
    // 중복확인 버튼 동작
    private func tappedCheckDuplicateButton() {
        
        // 1. 이메일 입력값 가져오기
        guard let emailText = signUpView.emailTextField.text, !emailText.isEmpty else {
            signUpView.checkEmailLabel.textColor = .red
            signUpView.checkEmailLabel.text = "이메일을 입력해주세요."
            return
        }
        
        // 2. 이메일 형식 확인
        if !checkEmailFormat(emailText) {
            signUpView.checkEmailLabel.textColor = .red
            signUpView.checkEmailLabel.text = "유효한 이메일 형식이 아닙니다."
            return
        }
        
        // 3. 저장된 데이터 이메일과 중복 비교
        if UserDataManger.shared.checkEmail(emailText) {
            signUpView.checkEmailLabel.textColor = .red
            signUpView.checkEmailLabel.text = "중복된 이메일입니다."
        } else {
            signUpView.checkEmailLabel.textColor = .green
            signUpView.checkEmailLabel.text = "사용 가능한 이메일입니다."
        }
    }
    
    // 회원가입 버튼 동작
    private func tappedSignUpButton() {
        guard let email = signUpView.emailTextField.text, !email.isEmpty,
              let nickName = signUpView.nickNameTextField.text, !nickName.isEmpty,
              let password = signUpView.pwTextField.text, !password.isEmpty,
              let name = signUpView.nameTextField.text, !name.isEmpty,
              let birth = signUpView.birthTextField.text, !birth.isEmpty,
              let phoneNumber = signUpView.phoneNumberTextField.text, !phoneNumber.isEmpty
        else {
            // 전체 입력이 되어있지 않다면 경고창을 띄움
            presentAlert()
            return
        }
        // CoreData에 저장
        createUserInfo(email: email, nickName: nickName, password: password, name: name, birth: birth, phoneNumber: phoneNumber)
        // 저장된 데이터 보기
        readUserInfo()
        // 로그인 화면으로 이동
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Metod Part

extension SignUpViewController {
    // 입력한 이메일이 올바른 형식인지 확인
    func checkEmailFormat(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
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
    
    // 경고창 생성
    func presentAlert() {
        let alert = UIAlertController(title: "경 고", message: "입력을 모두 해주시기 바랍니다.", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확 인", style: .default) { _ in
            print("확인 버튼을 눌렀습니다.")
        }
        alert.addAction(confirm)
        present(alert, animated: true)
    }
}

// MARK: - CoreData Part

extension SignUpViewController {
    
    // CoreData에 유저 데이터 생성
    func createUserInfo(email: String, nickName: String, password: String, name: String, birth: String, phoneNumber: String) {
        // 텍스트필드 값을 UserInfoData에 추가 후 생성
        let userInfo = UserInfoData.init(email: email, nickName: nickName, password: password, name: name, birth: birth, phoneNumber: phoneNumber)
        UserDataManger.shared.createUserData(userInfo)
    }
    
    // 저장된 유저 정보를 읽기
    func readUserInfo() {
        let users = UserDataManger.shared.getUserInfos()
        for user in users {
            print("User: \(user.email), \(user.nickName), \(user.password), \(user.name), \(user.birth), \(user.phoneNumber)")
        }
    }
}

// MARK: - TextField Part

extension SignUpViewController: UITextFieldDelegate {
    
    // 텍스트필드 setting
    private func textFieldSetup() {
        signUpView.emailTextField.delegate = self
        signUpView.nickNameTextField.delegate = self
        signUpView.pwTextField.delegate = self
        signUpView.pwCheckTextField.delegate = self
        signUpView.nameTextField.delegate = self
        signUpView.birthTextField.delegate = self
        signUpView.phoneNumberTextField.delegate = self
    }
    
    // 텍스트필드 입력 마쳤을 때 함수 호출(비밀번호 입력값이 동일한지 체크)
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == signUpView.pwCheckTextField {
            checkPassword()
        }
    }
    
    // 다음 텍스트필드로 넘어가기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case signUpView.emailTextField:
            signUpView.nickNameTextField.becomeFirstResponder()
        case signUpView.nickNameTextField:
            signUpView.pwTextField.becomeFirstResponder()
        case signUpView.pwTextField:
            signUpView.pwCheckTextField.becomeFirstResponder()
        case signUpView.pwCheckTextField:
            signUpView.nameTextField.becomeFirstResponder()
        case signUpView.nameTextField:
            signUpView.birthTextField.becomeFirstResponder()
        case signUpView.birthTextField:
            signUpView.phoneNumberTextField.becomeFirstResponder()
        case signUpView.phoneNumberTextField:
            textField.resignFirstResponder() // 마지막 텍스트 필드에서 키보드 내리기
        default:
            textField.resignFirstResponder() // 기본적으로 키보드 내리기
        }
        return true
    }
}

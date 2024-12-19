//
//  SignUpView.swift
//  LuckVii
//
//  Created by jae hoon lee on 12/16/24.
//

import UIKit
import SnapKit

class SignUpView: UIView {
    
    var duplicateButtonAction: (() -> Void)?
    var signUpButtonAction: (() -> Void)?
    
    // 스크롤뷰
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    // 스크롤뷰 안에 넣을 전체 뷰
    let contentView = UIView()
    
    // 이메일 뷰(라벨 + 스택뷰(텍스트필드 + 버튼))
    private let emailView: UIView = {
        let view = UIView()
        return view
    }()
    
    // 이메일 라벨
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디(이메일)"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    // 이메일 확인 라벨
    var checkEmailLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14)
        label.textColor = .red
        return label
    }()
    
    // 스택뷰(텍스트필드 + 버튼)
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    // 이메일 텍스트필드
    var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이메일 주소"
        textField.font = .systemFont(ofSize: 14)
        textField.textColor = .gray
        textField.clearButtonMode = .always
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        textField.autocorrectionType = .no
        return textField
    }()
    
    // 중복확인 버튼
    var duplicateCheckButton: UIButton = {
        let button = UIButton()
        button.setTitle("중복확인", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.layer.cornerRadius = 14
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.green.cgColor
        return button
    }()
    
    // 닉네임 뷰(라벨 + 텍스트필드)
    private let nickNameView: UIView = {
        let view = UIView()
        return view
    }()
    
    // 닉네임 라벨
    private let nickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    // 닉네임 텍스트필드
    var nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임"
        textField.font = .systemFont(ofSize: 14)
        textField.textColor = .gray
        textField.clearButtonMode = .always
        return textField
    }()
    
    // 비밀번호 뷰(라벨 + 텍스트필드)
    private let pwView: UIView = {
        let view = UIView()
        return view
    }()
    
    // 비밀번호 라벨
    private let pwLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    // 비밀번호 텍스트필드
    var pwTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.font = .systemFont(ofSize: 14)
        textField.textColor = .gray
        textField.clearButtonMode = .always
        textField.isSecureTextEntry = true
        return textField
    }()
    
    // 비밀번호 확인 뷰(라벨 + 텍스트필드)
    private let pwCheckView: UIView = {
        let view = UIView()
        return view
    }()
    
    // 비밀번호 확인 라벨
    private let pwCheckLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 확인"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    // 비밀번호 동일한 상태 확인 라벨
    var checkPwLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14)
        label.textColor = .red
        return label
    }()
    
    // 비밀번호 확인 텍스트필드
    var pwCheckTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호 확인"
        textField.font = .systemFont(ofSize: 14)
        textField.textColor = .gray
        textField.clearButtonMode = .always
        textField.isSecureTextEntry = true
        return textField
    }()
    
    // 이름 뷰(라벨 + 텍스트필드)
    private let nameView: UIView = {
        let view = UIView()
        return view
    }()
    
    // 이름 라벨
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    // 이름 텍스트필드
    var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "실명을 입력하세요."
        textField.font = .systemFont(ofSize: 14)
        textField.textColor = .gray
        textField.clearButtonMode = .always
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        textField.autocorrectionType = .no
        return textField
    }()
    
    // 생년월일 뷰(라벨 + 텍스트필드)
    private let birthView: UIView = {
        let view = UIView()
        return view
    }()
    
    // 생년월일 라벨
    private let birthLabel: UILabel = {
        let label = UILabel()
        label.text = "생년월일"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    // 생년월일 텍스트필드
    var birthTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "8자리 입력(ex.20241231)"
        textField.font = .systemFont(ofSize: 14)
        textField.textColor = .gray
        textField.clearButtonMode = .always
        return textField
    }()
    
    // 휴대폰번호 뷰(라벨 + 텍스트필드)
    private let phoneNumberView: UIView = {
        let view = UIView()
        return view
    }()
    
    // 휴대폰번호 라벨
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "휴대폰 번호"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    // 휴대폰번호 텍스트필드
    var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "'-' 구분없이 입력"
        textField.font = .systemFont(ofSize: 14)
        textField.textColor = .gray
        textField.clearButtonMode = .always
        return textField
    }()
    
    // 회원가입 버튼
    var signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 14
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        return button
    }()
    
    //MARK: - setting
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
        setUnderline()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        // MARK: - add view
        
        // 스택뷰(이메일 텍스트필드 + 중복확인 버튼)
        [
            emailTextField,
            duplicateCheckButton
        ].forEach { horizontalStackView.addArrangedSubview($0) }
        
        // 이메일 뷰(라벨 + 스택뷰) 추가
        [
            emailLabel,
            checkEmailLabel,
            horizontalStackView
        ].forEach { emailView.addSubview($0) }
        
        // 닉네임 뷰(라벨 + 텍스트필드) 추가
        [
            nickNameLabel,
            nickNameTextField
        ].forEach { nickNameView.addSubview($0) }
        
        // 비밀번호 뷰(라벨 + 텍스트필드) 추가
        [
            pwLabel,
            pwTextField
        ].forEach { pwView.addSubview($0) }
        
        // 비밀번호 확인 뷰(라벨 + 텍스트필드) 추가
        [
            pwCheckLabel,
            checkPwLabel,
            pwCheckTextField
        ].forEach { pwCheckView.addSubview($0) }
        
        // 이름 뷰(라벨 + 텍스트필드) 추가
        [
            nameLabel,
            nameTextField
        ].forEach { nameView.addSubview($0) }
        
        // 생년월일 뷰(라벨 + 텍스트필드) 추가
        [
            birthLabel,
            birthTextField
        ].forEach { birthView.addSubview($0) }
        
        // 휴대폰 번호 뷰(라벨 + 텍스트필드) 추가
        [
            phoneNumberLabel,
            phoneNumberTextField
        ].forEach { phoneNumberView.addSubview($0) }
        
        // content 뷰에 추가
        [
            emailView,
            nickNameView,
            pwView,
            pwCheckView,
            nameView,
            birthView,
            phoneNumberView,
            signUpButton
        ].forEach { contentView.addSubview($0) }
        
        // 스크롤 뷰에 콘텐트뷰 추가
        scrollView.addSubview(contentView)
        
        // 스크롤 뷰를 뷰에 추가
        addSubview(scrollView)
        
        // MARK: - layout
        
        // 이메일 뷰(라벨 + 스택뷰) Layout
        emailView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(74)
        }
        
        // 이메일 라벨 Layout
        emailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(22)
            make.width.equalTo(100)
        }
        
        // 이메일 확인 라벨 Layout
        checkEmailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(emailLabel.snp.trailing).offset(5)
            make.height.equalTo(22)
        }
        
        // 스택뷰(텍스트필드 + 버튼) Layout
        horizontalStackView.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        // 이메일 텍스트필드 Layout
        emailTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalTo(duplicateCheckButton.snp.leading)
        }
        
        // 중복확인 버튼 Layout
        duplicateCheckButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(3)
            make.width.equalTo(87)
        }
        
        // 닉네임 뷰(라벨 + 텍스트필드) Layout
        nickNameView.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(74)
        }
        
        // 닉네임 라벨 Layout
        nickNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(22)
        }
        
        // 닉네임 텍스트필드 Layout
        nickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(5)
            make.height.equalTo(44)
        }
        
        // 비밀번호 뷰(라벨 + 텍스트필드) Layout
        pwView.snp.makeConstraints { make in
            make.top.equalTo(nickNameView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(74)
        }
        
        // 비밀번호 라벨 Layout
        pwLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(22)
        }
        
        // 비밀번호 텍스트필드 Layout
        pwTextField.snp.makeConstraints { make in
            make.top.equalTo(pwLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(5)
            make.height.equalTo(44)
        }
        
        // 비밀번호 확인 뷰(라벨 + 텍스트필드) Layout
        pwCheckView.snp.makeConstraints { make in
            make.top.equalTo(pwView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(74)
        }
        
        // 비밀번호 확인 라벨 Layout
        pwCheckLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(22)
            make.width.equalTo(100)
        }
        
        // 비밀번호 동일한 상태 확인 라벨 Layout
        checkPwLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(pwCheckLabel.snp.trailing).offset(5)
            make.height.equalTo(22)
        }
        
        // 비밀번호 확인 텍스트필드 Layout
        pwCheckTextField.snp.makeConstraints { make in
            make.top.equalTo(pwCheckLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(5)
            make.height.equalTo(44)
        }
        
        // 이름 뷰(라벨 + 텍스트필드) Layout
        nameView.snp.makeConstraints { make in
            make.top.equalTo(pwCheckView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(74)
        }
        
        // 이름 라벨 Layout
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(22)
        }
        
        // 이름 텍스트필드 Layout
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(5)
            make.height.equalTo(44)
        }
        
        // 생년월일 뷰(라벨 + 텍스트필드) Layout
        birthView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(74)
        }
        
        // 생년월일 라벨 Layout
        birthLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(22)
        }
        
        // 생년월일 텍스트필드 Layout
        birthTextField.snp.makeConstraints { make in
            make.top.equalTo(birthLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(5)
            make.height.equalTo(44)
        }
        
        // 휴대폰번호 뷰(라벨 + 텍스트필드) Layout
        phoneNumberView.snp.makeConstraints { make in
            make.top.equalTo(birthView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(74)
        }
        
        // 휴대폰번호 라벨 Layout
        phoneNumberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(22)
        }
        
        // 휴대폰번호 텍스트필드 Layout
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(5)
            make.height.equalTo(44)
        }
        
        // 회원가입 버튼 Layout
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberView.snp.bottom).offset(120)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.bottom.equalTo(contentView).offset(-16)
        }
        
        // 콘텐트 뷰 Layout
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        // 스크롤 뷰 Layout
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - method part

extension SignUpView {
    
    // 텍스트필드 하단에 밑줄 생성 메서드
    private func addUnderlineView(to textField: UITextField) {
        let underlineView = UIView()
        underlineView.backgroundColor = .lightGray
        textField.addSubview(underlineView)
        
        underlineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    // 텍스트필드에 밑줄을 추가
    private func setUnderline() {
        [
            emailTextField,
            nickNameTextField,
            pwTextField,
            pwCheckTextField,
            nameTextField,
            birthTextField,
            phoneNumberTextField
        ].forEach { addUnderlineView(to: $0) }
    }
}

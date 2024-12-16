//
//  LoginView.swift
//  LuckVii
//
//  Created by jae hoon lee on 12/14/24.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    // 로고 이미지
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "dice")
        return imageView
    }()
    
    // 이메일 뷰(로고 + 텍스트필드)
    private let emailView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 22
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    // 이메일 아이콘
    private let emailIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .black
        return imageView
    }()
    
    // 이메일 텍스트필드
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email을 입력해주세요."
        textField.textColor = .gray
        textField.clearButtonMode = .always
        return textField
    }()
    
    // 비밀번호 뷰(로고 + 텍스트필드)
    private let pwView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 22
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    // 비밀번호 아이콘
    private let pwIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "lock")
        imageView.tintColor = .black
        return imageView
    }()
    
    // 비밀번호 텍스트필드
    private let pwTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "패스워드를 입력해주세요."
        textField.textColor = .gray
        textField.clearButtonMode = .always
        return textField
    }()
    
    // 로그인 버튼
    private let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 14
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        return button
    }()
    
    // 아이디 찾기 버튼
    private let findIDButton: UIButton = {
        let button = UIButton()
        button.setTitle("아이디 찾기", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
    }()
    
    // 비밀번호 찾기 버튼
    private let findPWButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 찾기", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
    }()
    
    // 회원가입 버튼
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
    }()
    
    // 스택뷰(아이디 찾기 + 비밀번호 찾기 + 회원가입)
    private let horiziontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        return stackView
    }()
    
    // 비회원 버튼
    private let noMemberButton: UIButton = {
        let button = UIButton()
        button.setTitle("비회원으로 이용하기", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.tintColor = .gray
        button.layer.cornerRadius = 14
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        return button
    }()
    
    //MARK: - setting
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        //MARK: - add view
        
        // 이메일 뷰 추가
        [
            emailIconImageView,
            emailTextField
        ].forEach { emailView.addSubview($0) }
        
        // 패스워드 뷰 추가
        [
            pwIconImageView,
            pwTextField
        ].forEach { pwView.addSubview($0) }
        
        // 아이디 찾기, 비밀번호 찾기, 회원가입 버튼 추가
        [
            findIDButton,
            findPWButton,
            signUpButton
        ].forEach { horiziontalStackView.addArrangedSubview($0) }
        
        // 뷰에 추가
        [
            logoImageView,
            emailView,
            pwView,
            loginButton,
            horiziontalStackView,
            noMemberButton
        ].forEach { addSubview($0) }

        //MARK: - layout
        
        // 로고 이미지 Layout
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(80)
            make.width.equalTo(150)
            make.height.equalTo(139)
        }
        
        // 이메일 뷰(아이콘 + 텍스트필드) Layout
        emailView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        // 이메일 아이콘 Layout
        emailIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(19)
            make.leading.equalToSuperview().offset(16)
        }
        
        // 이메일 텍스트필드 Layout
        emailTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(emailIconImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(15)

        }
        
        // 패스워드 뷰(아이콘 + 텍스트필드) Layout
        pwView.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        // 패스워드 아이콘 Layout
        pwIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(19)
            make.leading.equalToSuperview().offset(16)
        }
        
        // 패스워드 텍스트필드 Layout
        pwTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(emailIconImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(15)
        }
        
        // 로그인 버튼 Layout
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(pwView.snp.bottom).offset(27)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        // 스택뷰 Layout
        horiziontalStackView.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(261)
            make.height.equalTo(22)
        }
        
        // 비회원 버튼 Layout
        noMemberButton.snp.makeConstraints { make in
            make.top.equalTo(horiziontalStackView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}

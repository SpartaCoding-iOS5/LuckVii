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
    private let emailTextView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 22.5
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    // 이메일 아이콘
    private let emailIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .gray
        return imageView
    }()
    
    // 이메일 텍스트필드
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email을 입력해주세요."
        textField.textColor = .lightGray
        textField.clearButtonMode = .always
        return textField
    }()
    
    // 패스워드 뷰(로고 + 텍스트필드)
    private let pwTextView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 22.5
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    // 패스워드 아이콘
    private let pwIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "lock")
        imageView.tintColor = .gray
        return imageView
    }()
    
    // 패스워드 텍스트필드
    private let pwTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "패스워드를 입력해주세요."
        textField.textColor = .lightGray
        textField.clearButtonMode = .always
        return textField
    }()
    
    // 로그인 버튼
    private let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("로그인 하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        return button
    }()
    
    // 비회원 버튼
    private let noMemberButton: UIButton = {
        let button = UIButton()
        button.setTitle("비회원으로 보기", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        return button
    }()
    
    // 회원가입 버튼
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        return button
    }()
    
    // 스택뷰(비회원 + 회원가입)
    private let horiziontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    //MARK: - setting
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
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
        ].forEach { emailTextView.addSubview($0) }
        
        // 패스워드 뷰 추가
        [
            pwIconImageView,
            pwTextField
        ].forEach { pwTextView.addSubview($0) }
        
        // 비회원, 회원가입 버튼 추가
        [
            noMemberButton,
            signUpButton
        ].forEach { horiziontalStackView.addArrangedSubview($0) }
        
        // 뷰에 추가
        [
            logoImageView,
            emailTextView,
            pwTextView,
            loginButton,
            horiziontalStackView
        ].forEach { addSubview($0) }

        //MARK: - layout
        
        // 로고 이미지 Layout
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(80)
            make.width.height.equalTo(170)
        }
        
        // 이메일 뷰(아이콘 + 텍스트필드) Layout
        emailTextView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
        
        // 이메일 아이콘 Layout
        emailIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
            make.leading.equalToSuperview().offset(10)
        }
        
        // 이메일 텍스트필드 Layout
        emailTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(emailIconImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        // 패스워드 뷰(아이콘 + 텍스트필드) Layout
        pwTextView.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
        
        // 패스워드 아이콘 Layout
        pwIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
            make.leading.equalToSuperview().offset(10)
        }
        
        // 패스워드 텍스트필드 Layout
        pwTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(pwIconImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        // 로그인 버튼 Layout
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        // 비회원 버튼 Layout
        noMemberButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        
        // 회원가입 버튼 Layout
        signUpButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
        
        // 스택뷰 Layout
        horiziontalStackView.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(30)
        }
    }
}

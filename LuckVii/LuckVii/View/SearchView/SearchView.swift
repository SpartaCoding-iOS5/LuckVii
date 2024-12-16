//
//  SearchView.swift
//  LuckVii
//
//  Created by 박민석 on 12/15/24.
//

import UIKit
import SnapKit

class SearchView: UIView {
    
    // 앱 로고 레이블
    private let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "LuckVii"
        label.textAlignment = .center
        label.textColor = .label
        label.backgroundColor = .systemBackground
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    // 검색을 위한 텍스트 필드
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.textColor = .label
        textField.placeholder = "영화명을 입력해주세요."
        textField.clearButtonMode = .whileEditing // 텍스트 입력 중에만 x 버튼
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.cornerRadius = 22
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = paddingView    // 텍스트와 경계선 사이에 여백 추가
        textField.leftViewMode = .always
        return textField
    }()
    
    // 영화 목록을 띄우는 컬렉션 뷰
    let movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // 세로 스크롤
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false // 스크롤바 숨김
        view.backgroundColor = .systemBackground
        view.register(SearchViewCell.self, forCellWithReuseIdentifier: "SearchViewCell") // 셀 등록
        return view
    }()
    
    // MARK: - 생성자
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI 셋업
    
    private func setupUI() {
        [
            logoLabel,
            searchTextField,
            movieCollectionView
        ].forEach { addSubview($0) }
        
        logoLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(78)
            $0.leading.trailing.equalToSuperview().inset(130)
        }
        
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(logoLabel.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        movieCollectionView.snp.makeConstraints{
            $0.top.equalTo(searchTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-36)
        }
        
    }
    
    // 키보드 처리 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true) // 다른 곳 터치시 키보드 닫기
    }
}

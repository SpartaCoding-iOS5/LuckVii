//
//  SearchView.swift
//  LuckVii
//
//  Created by 박민석 on 12/15/24.
//

import UIKit
import SnapKit


protocol textFieldDelegate: AnyObject {
    func searchingMovie(_ input: String)
    func pressReturnKey()
}

class SearchView: UIView {
    
    weak var delegate: textFieldDelegate?
    
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
    private let searchTextField: UITextField = {
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
        textField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged) // 검색에 대한 메서드 호출
        textField.addTarget(self, action: #selector(returnKeypressed), for: .editingDidEndOnExit) // return 키 입력에 대한 메서드 호출
        return textField
    }()
    
    // 영화 목록을 띄우는 컬렉션 뷰
    private let movieCollectionView: UICollectionView = {
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
    
    // MARK: - 외부에서 호출 될 메서드
    
    // 컬렉션 뷰 delegate, dataSource 위임 메서드
    func setCollectionView(_ delegate: UICollectionViewDelegateFlowLayout, _ dataSource: UICollectionViewDataSource) {
        movieCollectionView.dataSource = dataSource
        movieCollectionView.delegate = delegate
    }
    
    // 컬렉션 뷰 리로드 메서드
    func reloadCollectionView() {
        movieCollectionView.reloadData()
    }
    
    // 텍스트 필드 값 변경 처리 메서드
    @objc func searchTextChanged() {
        let input = searchTextField.text ?? ""
        delegate?.searchingMovie(input)
    }
    
    // return 입력 처리 메서드
    @objc func returnKeypressed() {
        delegate?.pressReturnKey()
    }
}

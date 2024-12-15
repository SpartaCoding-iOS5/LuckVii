//
//  SearchView.swift
//  LuckVii
//
//  Created by 박민석 on 12/15/24.
//

import UIKit
import SnapKit

class SearchView: UIView {
    
    // 검색을 위한 텍스트 필드
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.textColor = .label
        textField.placeholder = "영화명을 입력해주세요."
        textField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
        textField.clearButtonMode = .whileEditing
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
        
        // 컬렉션 뷰 delegate, dataSource 설정
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI 셋업
    private func setupUI() {
        [
            searchTextField,
            movieCollectionView
        ].forEach { addSubview($0) }
        
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(120)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(12)
            $0.height.equalTo(40)
        }
        
        movieCollectionView.snp.makeConstraints{
            $0.top.equalTo(searchTextField.snp.bottom).offset(12)
            $0.leading.trailing.bottom.equalTo(safeAreaLayoutGuide).inset(12)
        }
        
    }
    
    // MARK: - 임시 데이터와 메서드 -> 아래 내용들은 컨트롤러 만들면 수정 및 이동 할 예정입니다
    
    // 텍스트필드 검색 입력 처리 메서드
    @objc private func searchTextChanged(_ textField: UITextField) {
        print("검색 텍스트: \(textField.text ?? "") ")
    }
    
    // 키보드 처리 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true) // 다른 곳 터치시 키보드 닫기
    }
    
    // 더미 데이터
    private let dummyMovies: [(image: UIImage?, name: String)] = [
        (UIImage(systemName: "film"), "영화 1"),
        (UIImage(systemName: "film"), "영화 2"),
        (UIImage(systemName: "film"), "영화 3"),
        (UIImage(systemName: "film"), "영화 4"),
        (UIImage(systemName: "film"), "영화 5"),
        (UIImage(systemName: "film"), "영화 6"),
        (UIImage(systemName: "film"), "영화 7"),
        (UIImage(systemName: "film"), "영화 8"),
        (UIImage(systemName: "film"), "영화 9"),
        (UIImage(systemName: "film"), "영화 10")
    ]
    
}

extension SearchView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchViewCell", for: indexPath) as! SearchViewCell
        cell.setCellData(movieImage: nil, movieName: "영화 \(indexPath.row + 1)")
        cell.backgroundColor = .systemBackground
        return cell
    }
    
    // 셀 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 3 // 가로로 배치할 셀 개수
        let spacing: CGFloat = 16 // 셀 간 간격
        let totalSpacing = (itemsPerRow - 1) * spacing // 전체 간격 계산
        let width = (collectionView.frame.width - totalSpacing) / itemsPerRow // 셀 너비 계산
        return CGSize(width: width, height: width * 1.5) // 세로 크기를 비율로 설정
    }
    
    // 셀 선택 처리 메서드
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        endEditing(true) // 키보드 내리기
    }
}

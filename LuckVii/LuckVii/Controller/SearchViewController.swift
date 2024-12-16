//
//  SearchViewController.swift
//  LuckVii
//
//  Created by 박민석 on 12/16/24.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    // 더미 데이터
    private let dummyMovies: [(image: UIImage?, name: String)] = [
        (UIImage(systemName: "nil"), "대가족"),
        (UIImage(systemName: "nil"), "소방관"),
        (UIImage(systemName: "nil"), "모아나 2"),
        (UIImage(systemName: "nil"), "위키드"),
        (UIImage(systemName: "nil"), "1승"),
        (UIImage(systemName: "nil"), "히든페이스"),
        (UIImage(systemName: "nil"), "서브스턴스"),
        (UIImage(systemName: "nil"), "극장판 주술회전 0"),
        (UIImage(systemName: "nil"), "더 크로우"),
        (UIImage(systemName: "nil"), "크리스마스에 기적을 만날 확률")
    ]
    
    // 더미 데이터에서 검색된 값 저장할 배열
    private var searchMovies = [(image: UIImage?, name: String)]()
    
    // 기본 뷰를 searchView로 설정
    private let searchView = SearchView()
    override func loadView() {
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.delegate = self
        
        // 초기 상태에서는 전체 데이터를 표시
        searchMovies = dummyMovies
        
        // delegate, dataSource를 self로 설정
        searchView.setCollectionView(self, self)
    }
}

// MARK: - 컬렉션 뷰 delegate, dataSource 설정

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // 섹션당 셀 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchMovies.count
    }
    
    // 셀 속성 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchViewCell", for: indexPath) as! SearchViewCell
        
        let movieData = searchMovies[indexPath.row]
        
        cell.setCellData(movieImage: movieData.image?.pngData(), movieName: movieData.name)
        cell.backgroundColor = .systemBackground
        
        return cell
    }
    
    // 셀 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 112
        let height = 198
        return CGSize(width: width, height: height)
    }
    
    // 셀 선택 처리 메서드
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchView.endEditing(true) // 키보드 내리기
        
        /* 영화 세부 페이지로 이동 처리 구현해야함 */
    }
}

// MARK: - 텍스트 필드 메서드

extension SearchViewController: textFieldDelegate {
    
    // 키보드 입력에 따라 컬렉션 뷰 출력 바꾸는 메서드
    @objc func searchingMovie(_ input: String) {
        print(input)
        
        if input.isEmpty {
            searchMovies = dummyMovies // 입력이 없으면 전체 데이터 출력
        } else {
            searchMovies = dummyMovies.filter { $0.name.contains(input) // 제목에 입력값이 포함된 영화 필터링
            }
        }
        
        // 컬렉션 뷰 리로드
        searchView.reloadCollectionView()
    }
    
    // 키보드의 return 버튼 클릭시 키보드 내리는 메서드
    func pressReturnKey() {
        view.endEditing(true)
    }
}

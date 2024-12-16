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
    let searchView = SearchView()
    override func loadView() {
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 초기 상태에서는 전체 데이터를 표시
        searchMovies = dummyMovies
        
        searchView.movieCollectionView.delegate = self
        searchView.movieCollectionView.dataSource = self
        searchView.searchTextField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
    }
    
    @objc func searchTextChanged(_ textField: UITextField) {
        let input = textField.text ?? ""
        print(input)
        
        if input.isEmpty {
            searchMovies = dummyMovies // 입력이 없으면 전체 데이터 출력
        } else {
            searchMovies = dummyMovies.filter { $0.name.contains(input)
            }
        }
        
        // 컬렉션 뷰 리로드
        searchView.movieCollectionView.reloadData()
    }
}

// MARK: - 컬렉션 뷰 delegate, dataSource 설정

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchMovies.count
    }
    
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
    }
}

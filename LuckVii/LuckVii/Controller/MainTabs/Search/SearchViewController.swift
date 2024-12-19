//
//  SearchViewController.swift
//  LuckVii
//
//  Created by 박민석 on 12/16/24.
//

import UIKit
import SnapKit

struct MovieDataSource {
    let movieData: Movie
    let image: UIImage?
}

class SearchViewController: UIViewController {
    
    // 영화 목록을 저장할 배열
    private var movieDataSource = [MovieDataSource]()
    
    // 검색된 영화 데이터 저장할 배열
    private var searchMovies = [MovieDataSource]()
    
    // 세그먼트 선택 메뉴 저장할 변수, 초기값은 .nowPlaying
    private var selectedCategory = NetworkManager.URLEndpointSet.nowPlaying
    
    // 검색 키워드 저장할 변수
    private var searchKeyword: String = ""
    
    // 기본 뷰를 searchView로 설정
    private let searchView = SearchView()
    override func loadView() {
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 네비게이션 셋업 호출
        setupNavigationBar()
        
        searchView.delegate = self
        
        // delegate, dataSource를 self로 설정
        searchView.setCollectionView(self, self)
        
        // 영화 데이터 가져오기
        fetchMovieData(selectedCategory)
    }
    
    func setupNavigationBar() {
        navigationItem.title = "영화 검색"
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
        
        cell.setCellData(movieData)
        cell.backgroundColor = .systemBackground
        
        return cell
    }
    
    // 셀 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 3 // 가로로 배치할 셀 개수
        let spcing: CGFloat = collectionView.frame.width * 0.03 // 셀 간 간격 (컬렉션 뷰 너비의 3%)
        let totalSpacing = (itemsPerRow - 1) * spcing // 전체 간격 계산
        let width = (collectionView.frame.width - totalSpacing) / itemsPerRow // 셀 너비 계산
        let height = width * 1.77
        return CGSize(width: width, height: height)
    }
    
    // 셀 선택 처리 메서드
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchView.endEditing(true) // 키보드 내리기
        
        /* 영화 세부 페이지로 이동 처리 구현해야함 */
        let selectedCell = searchMovies[indexPath.row]
        let detailVC = MovieDetailViewController()
        detailVC.setDetailViewData(selectedCell)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - 텍스트 필드 메서드

extension SearchViewController: textFieldDelegate {
    
    // 키보드 입력에 따라 컬렉션 뷰 출력 바꾸는 메서드
    @objc func searchingMovie(_ input: String) {
        print(input)
        searchKeyword = input   // 입력 저장
        
        if input.isEmpty {
            searchMovies = movieDataSource // 입력이 없으면 전체 데이터 출력
        } else {
            searchMovies = movieDataSource.filter { $0.movieData.title.contains(input) } // 제목에 입력값이 포함된 영화 필터링
        }
        
        // 컬렉션 뷰 리로드
        searchView.reloadCollectionView()
    }
    
    // 키보드의 return 버튼 클릭시 키보드 내리는 메서드
    func pressReturnKey() {
        view.endEditing(true)
    }
    
    // Segmented Control 선택 메서드
    func didChangeSegment(index: Int) {
        selectedCategory = (index == 0) ? .nowPlaying : .upcoming
        fetchMovieData(selectedCategory)
    }
}

// MARK: - 데이터 불러오기

extension SearchViewController {
    
    private func fetchMovieData(_ endPoint: NetworkManager.URLEndpointSet) {
        Task { [weak self] in
            do {
                // 1. MovieDataManager를 호출해 서버에서 영화 데이터 가져오기
                let movieData: MovieData = try await NetworkManager.shared.fetchData(
                    endpoint: endPoint,  // 'nowPlaying' 엔드포인트를 사용하여 현재 상영 중인 영화 목록을 요청
                    parameters: NetworkManager.URLParameterSet.common
                )
                
                var tempMovies = [MovieDataSource]()    // 임시로 데이터를 저장할 배열
                
                // 2. 가져온 영화 목록을 순회하며 각 영화에 대한 이미지 데이터를 요청
                for movie in movieData.results {
                    let posterPath = movie.posterPath   // 영화의 포스터 이미지 경로
                    let image = try await ImageManager.shared.fetchImage(
                        from: posterPath ?? "",
                        size: .w342
                    )
                    // MovieDataSource 구조체로 영화 데이터와 이미지를 묶어 저장
                    let movieSource = MovieDataSource(movieData: movie, image: image)
                    tempMovies.append(movieSource)  // // 임시 배열에 추가
                }
                
                // 3. 가져온 데이터를 메인 데이터 소스와 검색 결과 배열에 할당
                self?.movieDataSource = tempMovies  // 컬렉션 뷰에 표시할 배열 업데이트
                // 저장된 검색 키워드로 필터링
                if let keyword = self?.searchKeyword, !keyword.isEmpty {
                    self?.searchMovies = tempMovies.filter { $0.movieData.title.contains(keyword) }
                } else {
                    self?.searchMovies = tempMovies // 초기 화면에 데이터를 표시
                }
                
                // 4. UI 업데이트는 메인 스레드에서 실행
                DispatchQueue.main.async {
                    self?.searchView.reloadCollectionView() // 컬렉션 뷰 리로드
                }
            } catch {
                // 5. 데이터 가져오기 실패 시 에러 메시지 출력
                print("데이터 불러오기 실패")
            }
        }
    }
}

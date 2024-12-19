//
//  CategoryViewController+Extension.swift
//  LuckVii
//
//  Created by 박진홍 on 12/19/24.
//

import UIKit

extension CategoryViewController {
    private func fetchMovieData(endPoint: NetworkManager.URLEndpointSet, parameter: URLParameters) async-> Array<MovieDataSource> {
        var movieDataSources = [MovieDataSource]()    // 임시로 데이터를 저장할 배열
        do {
            // 1. MovieDataManager를 호출해 서버에서 영화 데이터 가져오기
            let movieData: MovieData = try await NetworkManager.shared.fetchData(
                endpoint: endPoint,  // 'nowPlaying' 엔드포인트를 사용하여 현재 상영 중인 영화 목록을 요청
                parameters: parameter
            )
            // 2. 가져온 영화 목록을 순회하며 각 영화에 대한 이미지 데이터를 요청
            for movie in movieData.results {
                let posterPath = movie.posterPath   // 영화의 포스터 이미지 경로
                let image = try await ImageManager.shared.fetchImage(
                    from: posterPath ?? "",
                    size: .w342
                )
                // MovieDataSource 구조체로 영화 데이터와 이미지를 묶어 저장
                let movieSource = MovieDataSource(movieData: movie, image: image)
                movieDataSources.append(movieSource)  // // 임시 배열에 추가
            }
        } catch {
            // 5. 데이터 가져오기 실패 시 에러 메시지 출력
            print("데이터 불러오기 실패")
        }
        
        return movieDataSources
    }
    
    func insertMovieData() {
        let commonParameter = NetworkManager.URLParameterSet.common
        let secondPageParameter = NetworkManager.URLParameterSet.secondPage
        Task {
            self.upcomingMovies = await fetchMovieData(endPoint: .upcoming, parameter: commonParameter)
            self.nowPlayingMovies = await fetchMovieData(endPoint: .nowPlaying, parameter: secondPageParameter)
            self.popularMovies = await fetchMovieData(endPoint: .popular, parameter: commonParameter)
            
            DispatchQueue.main.async {
                self.upcomingCollectionView.reloadData()
                self.nowPlayingCollectionView.reloadData()
                self.popularCollectionView.reloadData()
            }
        }
    }
}

// MARK: - 컬렉션뷰 데이터 소스 및 델리게이트

extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case upcomingCollectionView:
            return upcomingMovies.count
        case nowPlayingCollectionView:
            return nowPlayingMovies.count
        case popularCollectionView:
            return popularMovies.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MoviePosterCell.identifier,
            for: indexPath
        ) as? MoviePosterCell else {
            print("failed to configure category view cell")
            return UICollectionViewCell()//비어있는 셀 반환
        }
        
        let movie: MovieDataSource
        
        switch collectionView {
        case upcomingCollectionView:
            movie = upcomingMovies[indexPath.item]
        case nowPlayingCollectionView:
            movie = nowPlayingMovies[indexPath.item]
        case popularCollectionView:
            movie = popularMovies[indexPath.item]
        default:
            fatalError("Unexpected collection view")
        }
        
        cell.configure(with: movie)
        return cell
    }
}

extension CategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie: MovieDataSource
        switch collectionView {
        case upcomingCollectionView:
            movie = upcomingMovies[indexPath.item]
        case nowPlayingCollectionView:
            movie = nowPlayingMovies[indexPath.item]
        case popularCollectionView:
            movie = popularMovies[indexPath.item]
        default:
            return
        }
        
        print("Selected movie: \(movie.movieData.title)")//연결된 영화 타이틀 선택
        let detailVC = MovieDetailViewController()
        detailVC.setDetailViewData(movie)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

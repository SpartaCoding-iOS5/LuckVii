//
//  CategoryViewController.swift
//  LuckVii
//
//  Created by 박진홍 on 12/19/24.
//

import UIKit

final class CategoryViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let stackView = UIStackView()

    private let upcomingCollectionView = MovieCollectionView()
    private let nowPlayingCollectionView = MovieCollectionView()
    private let popularCollectionView = MovieCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Movies"

        setupScrollView()
        setupStackView()
        setupCollectionViews()
        fetchData()
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor), // safeAreaLayoutGuide -> topAnchor로 변경
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    private func setupCollectionViews() {
        addSection(title: "Upcoming Movies", collectionView: upcomingCollectionView)
        addSection(title: "Now Playing", collectionView: nowPlayingCollectionView)
        addSection(title: "Popular Movies", collectionView: popularCollectionView)
    }

    private func addSection(title: String, collectionView: MovieCollectionView) {
        let sectionLabel = UILabel()
        sectionLabel.text = title
        sectionLabel.font = .boldSystemFont(ofSize: 18)
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(sectionLabel)
        stackView.addArrangedSubview(collectionView)
        
        collectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true // 각 컬렉션뷰 높이
    }

    private func fetchData() {
        Task {
            do {
                // 각각의 컬렉션뷰에 데이터를 로드
                let upcomingMovies:MovieData = try await NetworkManager.shared.fetchData(endpoint: .upcoming, parameters: NetworkManager.URLParameterSet.common)
                
                let nowPlayingMovies = try await fetchMovies(for: .nowPlaying)
                let popularMovies = try await fetchMovies(for: .popular)

                upcomingCollectionView.update(with: upcomingMovies.results)
                nowPlayingCollectionView.update(with: nowPlayingMovies)
                popularCollectionView.update(with: popularMovies)
            } catch {
                print("Failed to fetch data: \(error)")
            }
        }
    }

    private func fetchMovies(for category: NetworkManager.URLEndpointSet) async throws -> [Movie] {
        let parameters = NetworkManager.URLParameterSet.common
        let movieData: MovieData = try await NetworkManager.shared.fetchData(endpoint: category, parameters: parameters)
        return movieData.results
    }
}

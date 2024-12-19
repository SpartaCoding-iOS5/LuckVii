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

    let upcomingCollectionView = MovieCollectionView()
    let nowPlayingCollectionView = MovieCollectionView()
    let popularCollectionView = MovieCollectionView()

    var upcomingMovies: [MovieDataSource] = []
    var nowPlayingMovies: [MovieDataSource] = []
    var popularMovies: [MovieDataSource] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Movies"
        
        insertMovieData()
        setupScrollView()
        setupStackView()
        setupCollectionViews()
        
    }

    // MARK: - UI 셋업
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
        setupCollectionView(collectionView: upcomingCollectionView, title: "Upcoming Movies")
        setupCollectionView(collectionView: nowPlayingCollectionView, title: "Now Playing")
        setupCollectionView(collectionView: popularCollectionView, title: "Popular Movies")
    }

    // MARK: - 컬렉션 뷰 셋업
    
    private func setupCollectionView(collectionView: UICollectionView, title: String) {
        let sectionLabel = UILabel()
        sectionLabel.text = title
        sectionLabel.font = .boldSystemFont(ofSize: 18)
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(sectionLabel)
        stackView.addArrangedSubview(collectionView)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MoviePosterCell.self, forCellWithReuseIdentifier: MoviePosterCell.identifier)

        collectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }

}


//
//  MovieCollectionView.swift
//  LuckVii
//
//  Created by 박진홍 on 12/19/24.
//

import UIKit

final class MovieCollectionView: UICollectionView {

    private var movies: [Movie] = []

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 200)
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        super.init(frame: .zero, collectionViewLayout: layout)

        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false

        delegate = self
        dataSource = self
        register(MoviePosterCell.self, forCellWithReuseIdentifier: MoviePosterCell.identifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with movies: [Movie]) {
        self.movies = movies
        print("Updating movies: \(movies.count)") // 디버깅
        reloadData()
    }
}

extension MovieCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Number of items: \(movies.count)") // 디버깅
        return movies.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        print("Configuring cell at \(indexPath.row)") // 디버깅
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MoviePosterCell.identifier,
            for: indexPath
        ) as? MoviePosterCell else {
            fatalError("Failed to dequeue MoviePosterCell")
        }

        let movie = movies[indexPath.item]
        cell.configure(with: movie)
        return cell
    }
}

extension MovieCollectionView: UICollectionViewDelegate {}

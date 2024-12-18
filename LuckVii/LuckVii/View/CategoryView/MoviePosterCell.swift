//
//  Untitled 2.swift
//  LuckVii
//
//  Created by 박진홍 on 12/19/24.
//

import UIKit

final class MoviePosterCell: UICollectionViewCell {
    static let identifier = "MoviePosterCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
//        label.textAlignment = .center
        label.numberOfLines = 2

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - UI 셋업

    private func setupUI() {
        [imageView, titleLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(view)
        }

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.5), // 이미지 높이

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func configure(with movie: MovieDataSource) {// 셀의 타이틀과 이미지 설정
        titleLabel.text = movie.movieData.title
        guard let image = movie.image else {
            imageView.image = UIImage(systemName: "photo") // 오류 시 기본 이미지
            return
        }
        imageView.image = image
    }
}

//
//  MyPageViewCell.swift
//  LuckVii
//
//  Created by Jamong on 12/17/24.
//

import UIKit
import SnapKit

// MARK: - movieReservationItemCell

final class MovieReservationCell: UITableViewCell {
    static let identifier = "MovieReservationCell"

    // MARK: - UI Components
    /// 포스터 이미지 뷰
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        return imageView
    }()

    /// 제목 라벨
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "소방관"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    /// 영화 일정 라벨
    private let dateTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "24.12.16 15:00~16:46"
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()

    /// 영화관 위치 라벨
    private let theaterLabel: UILabel = {
        let label = UILabel()
        label.text = "영등포 롯데시네마 1관 6층 (아이맥스) C9 2명"
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()

    /// 가격 라벨
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "60,000원"
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()

    // MARK: - StackViews
    private lazy var infoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, dateTimeLabel, theaterLabel, priceLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        return stack
    }()

    private lazy var cellStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [posterImageView, infoStack])
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .leading
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true

        posterImageView.snp.makeConstraints {
            $0.width.equalTo(81)
        }
        return stack
    }()

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupLayout() {
        contentView.addSubview(cellStack)

        cellStack.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }

    // MARK: - Configuration
    func configure(with movie: ReservationInfoData) {
        titleLabel.text = movie.title
        dateTimeLabel.text = movie.dateTime
        theaterLabel.text = movie.theater
        priceLabel.text = "\(NumberFormatter.localizedString(from: NSNumber(value: movie.price), number: .decimal))원"
        
        if let posterImage = movie.posterImage {
            posterImageView.image = posterImage
        } else {
            posterImageView.image = UIImage(named: "defaultPoster")
        }
    }
}

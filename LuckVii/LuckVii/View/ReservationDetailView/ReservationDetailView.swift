//
//  ReservationDetailView.swift
//  LuckVii
//
//  Created by Jamong on 12/19/24.
//

import UIKit
import SnapKit

class ReservationDetailView: UIView {

    // MARK: - ScrollView
    /// 스크롤 뷰 (테이블이 셀이 넘었을 때)
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "소방관"
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    private let dateTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2024.12.16 (월) 15:00~16:00 관람"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        return imageView
    }()

    private let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "상세정보"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private let theaterIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "building")
        imageView.tintColor = .darkGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let theaterLabel: UILabel = {
        let label = UILabel()
        label.text = "영등포롯데 멀티플렉스(아트) 6관"
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    private let screenTypeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "movieclapper")
        imageView.tintColor = .darkGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let screenTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "2D"
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    private let seatIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chair.lounge")
        imageView.tintColor = .darkGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let seatLabel: UILabel = {
        let label = UILabel()
        label.text = "C9-10석"
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    private let personIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .darkGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let personCount: UILabel = {
        let label = UILabel()
        label.text = "C9-10석"
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    private let priceIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "wonsign.circle")
        imageView.tintColor = .darkGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "60,000원"
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    // MARK: - StackView
    private lazy var titleDateStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, dateTimeLabel])
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .center
        return stack
    }()

    private lazy var titlePosterStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleDateStack, posterImageView])
        stack.axis = .vertical
        stack.spacing = 30
        stack.alignment = .center
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true

        posterImageView.snp.makeConstraints {
            $0.width.equalTo(176)
            $0.height.equalTo(252)
        }
        return stack
    }()

    private lazy var theaterStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [theaterIcon, theaterLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.backgroundColor = UIColor(red: 255/255, green: 247/255, blue: 240/255, alpha: 1)
        stack.layer.cornerRadius = 8
        stack.layoutMargins = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        theaterIcon.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
        return stack
    }()

    private lazy var screenTypeStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [screenTypeIcon, screenTypeLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.backgroundColor = UIColor(red: 248/255, green: 240/255, blue: 240/255, alpha: 1)
        stack.layer.cornerRadius = 8
        stack.layoutMargins = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        screenTypeIcon.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
        return stack
    }()

    private lazy var seatStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [seatIcon, seatLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.backgroundColor = UIColor(red: 252/255, green: 248/255, blue: 239/255, alpha: 1)
        stack.layer.cornerRadius = 8
        stack.layoutMargins = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        seatIcon.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
        return stack
    }()

    private lazy var personStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [personIcon, personCount])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.backgroundColor = UIColor(red: 255/255, green: 240/255, blue: 240/255, alpha: 1)
        stack.layer.cornerRadius = 8
        stack.layoutMargins = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        personIcon.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
        return stack
    }()

    private lazy var priceStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [priceIcon, priceLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.backgroundColor = UIColor(red: 247/255, green: 243/255, blue: 253/255, alpha: 1)
        stack.layer.cornerRadius = 8
        stack.layoutMargins = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        priceIcon.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
        return stack
    }()

    private lazy var infoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [theaterStack, screenTypeStack, seatStack, personStack, priceStack])
        stack.axis = .vertical
        stack.spacing = 8
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()

    // MARK: - Initalization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        /// 스크롤 뷰 전체 삽입
        addSubview(scrollView)

        let contentView = UIView()
        scrollView.addSubview(contentView)

        [titlePosterStack, detailLabel, infoStackView].forEach { contentView.addSubview($0) }

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }

        titlePosterStack.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        detailLabel.snp.makeConstraints {
            $0.top.equalTo(titlePosterStack.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(32)
        }

        infoStackView.snp.makeConstraints {
            $0.top.equalTo(detailLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(contentView).offset(-16)
        }
    }

    // MARK: - Configuration
    func configure(with reservation: ReservationInfoData) {
        titleLabel.text = reservation.title
        dateTimeLabel.text = reservation.dateTime
        theaterLabel.text = reservation.theater
        priceLabel.text = "\(NumberFormatter.localizedString(from: NSNumber(value: reservation.price), number: .decimal))원"
        seatLabel.text = reservation.seatNumber
        personCount.text = "\(reservation.ticketCount)명"
        
        if let posterImage = reservation.posterImage {
            posterImageView.image = posterImage
        } else {
            posterImageView.image = UIImage(named: "defaultPoster")
        }
    }
 }

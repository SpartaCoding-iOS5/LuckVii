//
//  MyPageView.swift
//  LuckVii
//
//  Created by Jamong on 12/17/24.
//

import UIKit
import SnapKit

final class MyPageView: UIView {

    // MARK: - ScrollView
    /// 스크롤 뷰 (테이블이 셀이 넘었을 때)
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    // MARK: - UI Components
    /// 이름(닉네임)라벨 - (1), 2
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "럭비님"
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()

    /// 환영 라벨 - (1), 2
    private let welcomLabel: UILabel = {
       let label = UILabel()
        label.text = "안녕하세요"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    /// 로그인 전환 버튼
    var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        return button
    }()

//    /// 프로필 이미지 뷰 - 2
//    private let profileImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.cornerRadius = 40.5
//        imageView.layer.borderWidth = 1
//        imageView.layer.borderColor = UIColor.lightGray.cgColor
//        imageView.clipsToBounds = true
//        imageView.snp.makeConstraints {
//            $0.width.height.equalTo(81)
//        }
//        return imageView
//    }()

    /// 쿠폰함 라벨 - (3), 6
    private let couponLabel: UILabel = {
        let label = UILabel()
        label.text = "쿠폰함"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    /// 쿠폰함 갯수 라벨 - (3), 6
    private let couponCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    /// 영화 예매수 라벨 - (4), 6
    private let movieRvLabel: UILabel = {
        let label = UILabel()
        label.text = "영화예매수"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    /// 영화 예매수 갯수 라벨 - (4), 6
    private let movieRvCountLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    /// 등급 라벨 - (5), 6
    private let gradeLabel: UILabel = {
        let label = UILabel()
        label.text = "등급"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    /// 유저 등급 라벨 - (5), 6
    private let gradeDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "VIP"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    /// 영화 예매 내역 라벨
    private let movieRvDetailsLabel: UILabel = {
        let label = UILabel()
        label.text = "영화 예매 내역"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    /// 바닥 선
    private let border: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    /// 영화 예매 내역 테이블
    let movieReservationTableView: UITableView = {
        let table = UITableView()
        table.register(MovieReservationCell.self, forCellReuseIdentifier: MovieReservationCell.identifier)
        table.rowHeight = 120
        table.isScrollEnabled = false
        return table
    }()

    // MARK: - StackViews
    /// 이름-환영 스택뷰
    private lazy var nameWelcomStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, welcomLabel])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .leading
        return stack
    }()

    /// 이름-환영 스택뷰 - 프로필 이미지 뷰의 스택뷰
    private lazy var profileStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameWelcomStack, /*profileImageView*/ loginButton])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()

    /// 쿠폰함 셋 스택뷰
    private lazy var couponStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [couponCountLabel, couponLabel])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        return stack
    }()

    /// 영화 예매수 셋 스택뷰
    private lazy var movieRvStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [movieRvCountLabel, movieRvLabel])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        return stack
    }()

    /// 등급 셋 스택뷰
    private lazy var gradeStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [gradeDetailLabel, gradeLabel])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        return stack
    }()

    /// 쿠폰함-영화-등급 스택뷰
    private lazy var infoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [couponStack, movieRvStack, gradeStack])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.layoutMargins = UIEdgeInsets(top: 20, left: 32, bottom: 20, right: 32)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()

    /// 영화 예매 내역 - 바닥 선 스택뷰
    private lazy var movieRvDetailStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [movieRvDetailsLabel, border])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill

        movieRvDetailsLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
        }

        border.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }

        return stack
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 테이블뷰 높이 제약조건
    private var tableViewHeightConstraint: Constraint?

    func updateTableViewHeight(numberOfRows: Int) {
        let height = CGFloat(numberOfRows) * movieReservationTableView.rowHeight
        tableViewHeightConstraint?.update(offset: height)
        layoutIfNeeded()
    }

    // MARK: - Setup
    private func setupStackViews() {
        /// 스크롤 뷰 전체 삽입
        addSubview(scrollView)

        let contentView = UIView()
        scrollView.addSubview(contentView)

        [
            profileStack,
            infoStack,
            movieRvDetailStack,
            movieReservationTableView
        ].forEach { contentView.addSubview($0) }

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }

        profileStack.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(16)
            $0.leading.trailing.equalToSuperview().inset(48)
        }

        infoStack.snp.makeConstraints {
            $0.top.equalTo(profileStack.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        movieRvDetailStack.snp.makeConstraints {
            $0.top.equalTo(infoStack.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview()
        }

        movieReservationTableView.snp.makeConstraints {
            $0.top.equalTo(movieRvDetailStack.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            tableViewHeightConstraint = $0.height.equalTo(0).constraint
        }
    }
}

extension MyPageView {

    func setupLoginUI(_ nickName: String) {
        print(nickName)
        nameLabel.text = nickName
        loginButton.setTitle("로그아웃", for: .normal)
    }

    func setupLogoutUI() {
        nameLabel.text = "로그인을 해주세요"
        movieRvCountLabel.text = "0"
        gradeDetailLabel.text = "0"
        loginButton.setTitle("로그인", for: .normal)
    }
}

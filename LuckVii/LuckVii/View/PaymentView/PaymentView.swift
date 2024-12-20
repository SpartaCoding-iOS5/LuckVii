//
//  PaymentView.swift
//  LuckVii
//
//  Created by mun on 12/16/24.
//

import UIKit
import SnapKit

final class PaymentView: UIView {

    var ticketCount = 1 // 티켓 갯수를 저장할 변수

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    // 영화 정보 View
    private let movieInformationView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        return view
    }()

    // 영화 포스터 ImageView
    private let moviePosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()

    private let movieInformationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        return stackView
    }()

    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "소방관" // 테스트 코드
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    private let movieDateTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2024-12-18(수) 14:30" // 테스트 코드
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()

    private let movieLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "럭비시네마 7층 1관"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()

    private let movieAgeLabel: UILabel = {
        let label = UILabel()
        label.text = "전체 관람가"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()

    private let totalPriceListView: UIView = {
        let view = UIView()
        return view
    }()

    private let totalPriceListLabel: UILabel = {
        let label = UILabel()
        label.text = "최종결제내역"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    private let totalPriceDetailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.layer.cornerRadius = 10
        stackView.clipsToBounds = true
        stackView.layer.borderColor = UIColor.gray.cgColor
        stackView.layer.borderWidth = 1
        return stackView
    }()

    private let ticketPriceView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private let ticketPriceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "티켓금액(1매)"
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    private let ticketPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "30,000원"
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    private let ticketCountView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private let ticketCountTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "인원"
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    private let ticketCountButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.backgroundColor = .lightGray
        stackView.layer.cornerRadius = 5
        stackView.clipsToBounds = true
        return stackView
    }()

    private let ticketCountPlusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapCountButton), for: .touchUpInside)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        return button
    }()

    private let ticketCountMinusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapCountButton), for: .touchUpInside)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        return button
    }()

    private lazy var ticketCountLabel: UILabel = {
        let label = UILabel()
        label.text = "x \(ticketCount)"
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    private let totalPriceView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private let totalPriceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "총 결제금액"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    lazy var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "\(PriceFormatModel.wonFormat(ticketCount*30000))"

        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    private let termsView: UIView = {
        let view = UIView()
        return view
    }()

    private let termsLabel: UILabel = {
        let label = UILabel()
        label.text = "약관 동의"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    private let termsDetailView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        return view
    }()

    private let termsDetatilLabel: UILabel = {
        let label = UILabel()
        label.text = "약관 동의하기"
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    var termsAgreementButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.circle"), for: .selected)

        return button
    }()

    private let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()

    var bottomButtonView = BottomButonView()

    // MARK: - 기본 설정

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 레이아웃 설정

    private func configureUI() {
        bottomButtonView.nextButton.setTitle("결제", for: .normal)

        self.addSubview(scrollView)
        self.addSubview(bottomButtonView)

        let contentView = UIView()
        scrollView.addSubview(contentView)

        // 뷰에 추가
        [
            movieInformationView,
            totalPriceListView,
            termsView
        ].forEach {
            contentView.addSubview($0)
        }

        // 영화 정보 뷰 추가
        [
            moviePosterImageView,
            movieInformationStackView
        ].forEach {
            movieInformationView.addSubview($0)
        }

        // 영화 정보 스택뷰 추가
        [
            movieTitleLabel,
            movieDateTimeLabel,
            movieAgeLabel,
            movieLocationLabel
        ].forEach {
            movieInformationStackView.addArrangedSubview($0)
        }

        // 최종결제내역 뷰 추가
        [
            totalPriceListLabel,
            totalPriceDetailStackView
        ].forEach {
            totalPriceListView.addSubview($0)
        }

        // 최종결제내역 리스트 뷰 추가
        [
            ticketPriceView,
            ticketCountView,
            totalPriceView
        ].forEach {
                totalPriceDetailStackView.addArrangedSubview($0)
        }

        // 티켓금액 뷰 추가
        [ticketPriceTitleLabel, ticketPriceLabel].forEach {
            ticketPriceView.addSubview($0)
        }

        // 인원 뷰 추가
        [ticketCountTitleLabel, ticketCountButtonStackView, ticketCountLabel].forEach {
            ticketCountView.addSubview($0)
        }

        // 인원 증감 버튼 스택뷰 추가
        [ticketCountMinusButton, ticketCountPlusButton].forEach {
            ticketCountButtonStackView.addArrangedSubview($0)
        }

        // 총 결제금액 뷰 추가
        [totalPriceTitleLabel, totalPriceLabel].forEach {
            totalPriceView.addSubview($0)
        }

        // 약관 동의 뷰 추가
        [termsLabel, termsDetailView].forEach {
            termsView.addSubview($0)
        }

        // 약관 동의 리스트 추가
        [termsDetatilLabel, termsAgreementButton].forEach {
            termsDetailView.addSubview($0)
        }

        let safeArea = self.safeAreaLayoutGuide // safeArea 변수 생성

        scrollView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(safeArea.snp.top).inset(10)
            $0.bottom.equalTo(bottomButtonView.snp.top).offset(-10)
        }

        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }

        movieInformationView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(200)
        }

        moviePosterImageView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview().inset(15)
            $0.width.equalTo(120)
        }

        movieInformationStackView.snp.makeConstraints {
            $0.leading.equalTo(moviePosterImageView.snp.trailing).offset(20)
            $0.top.bottom.equalToSuperview().inset(20)
        }

        totalPriceListView.snp.makeConstraints {
            $0.top.equalTo(movieInformationView.snp.bottom).offset(40)
            $0.leading.trailing.equalTo(movieInformationView)
            $0.height.equalTo(200)
        }

        totalPriceListLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }

        totalPriceDetailStackView.snp.makeConstraints {
            $0.top.equalTo(totalPriceListLabel.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        ticketPriceTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(15)
        }

        ticketPriceLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(15)
        }

        ticketCountTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(15)
        }

        ticketCountButtonStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(ticketCountTitleLabel.snp.trailing).offset(10)
        }

        ticketCountLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(15)
        }

        totalPriceTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(15)
        }

        totalPriceLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(15)
        }

        termsView.snp.makeConstraints {
            $0.top.equalTo(totalPriceView.snp.bottom).offset(40)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalTo(movieInformationView)
            $0.height.equalTo(80)
        }

        termsLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }

        termsDetailView.snp.makeConstraints {
            $0.top.equalTo(termsLabel.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        termsDetatilLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }

        termsAgreementButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }

        bottomButtonView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalTo(safeArea.snp.bottom).inset(10)
            $0.height.equalTo(50)
        }
    }

    // MARK: - 버튼 액션 설정

    // 인원 버튼 액션
    @objc func didTapCountButton(_ sender: UIButton) {
        if sender.titleLabel?.text == "+" {
            ticketCount += 1
            ticketCountLabel.text = "x \(ticketCount)"
        } else {
            if ticketCount > 1 {
                ticketCount -= 1
            }
            ticketCountLabel.text = "x \(ticketCount)"
        }
        totalPriceLabel.text = "\(PriceFormatModel.wonFormat(ticketCount * 30000))"
    }
}

extension PaymentView {

    // 전달 받은 데이터 설정
    func setPaymentView(movie: MovieDataSource, date: String, time: String) {
        movieTitleLabel.text = movie.movieData.title
        moviePosterImageView.image = movie.image
        movieDateTimeLabel.text = "\(date) \(time)"

        if movie.movieData.adult {
            movieAgeLabel.text = "19세 이상 관람가"
        } else {
            movieAgeLabel.text = "전체 관람가"
        }
    }
}

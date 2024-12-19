//
//  AgreementTermsView.swift
//  LuckVii
//
//  Created by mun on 12/17/24.
//

import UIKit

class AgreementTermsView: UIView {

    // 타이틀 Label
    private let titleLable: UILabel = {
        let label = UILabel()
        label.text = "럭비시네마 서비스 약관"
        label.font = .boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    // 서비스 이용약관 타이틀 Label
    private let serviceTermsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "서비스 이용약관 동의"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    // 서비스 이용약관 ScrollView
    private let serviceTermsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = .white
        scrollView.layer.borderColor = UIColor.lightGray.cgColor
        scrollView.showsVerticalScrollIndicator = false
        scrollView.layer.borderWidth = 1
        return scrollView
    }()

    // 서비스 이용약관 텍스트 Label
    private let serviceTermsTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = """
제 1조 (목적)
본 약관은 럭비시네마(이하 "회사”)가 제공하는 영화 예매 서비스와 결제 시 랜덤 당첨 기능을 이용하는 고객(이하 "이용자") 간의 권리, 의무 및 책임 사항을 규정함을 목적으로 합니다. 

제 2조 (약관의 적용 및 변경)
본 약관은 회사의 서비스 화면에 게시하여 공지함으로써 효력이 발생합니다. 회사는 필요한 경우 관련 법령을 위반하지 않는 범위에서 약관을 변경할 수 있으며, 변경된 약관은 동일한 방법으로 공지합니다. 변경된 약관에 동의하지 않을 경우 이용자는 서비스 이용을 중단할 수 있습니다.

제3조 (영화 예매 및 결제)
이용자는 신용카드, 체크카드, 계좌이체, 상품권 등 회사가 정한 결제 수단을 통해 영화 예매 결제를 진행할 수 있습니다. 결제가 완료된 시점에 예매는 확정되며, 예매 완료 메시지 또는 이메일을 통해 확인할 수 있습니다. 예매 취소 시 **취소 정책**에 따라 환불이 진행됩니다.

제4조 (이용자의 의무)
1 이용자는 예매 시 정확한 정보를 제공해야 합니다.
2 이용자는 본인의 예매 정보를 타인에게 양도하거나 공유할 수 없습니다.
3 이용자는 영화 시작 시간을 준수해야 하며, 지연 입장으로 인한 불이익은 이용자 본인의 책임입니다.

제5조 (기타사항)
1 본 약관에 명시되지 않은 사항은 회사 정책 및 관련 법령에 따릅니다.
2 서비스와 관련된 모든 분쟁은 회사의 관할 법원에 제소할 수 있습니다.
"""
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .justified
        return label
    }()

    // 랜덤 티켓 약관 Label
    private let randomTermsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "랜덤 티켓 약관 동의"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()

    // 랜덤 티켓 약관 ScrollView
    private let randomTermsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = .white
        scrollView.layer.borderColor = UIColor.lightGray.cgColor
        scrollView.showsVerticalScrollIndicator = false
        scrollView.layer.borderWidth = 1
        return scrollView
    }()

    // 랜덤 티켓 약관 텍스트 Label
    private let randomTermsTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = """
결제시 최초에 3만원 선결제가 이루어지고 최종 금액을 차감 후 페이백 해드립니다.

최종 금액 확률 (%)
30,000원 5%
25,000원 10%
20,000원 30%
15,000원 50%
10,000원 10%
5,000원 5%

유의사항
페이백은 결제와 동시에 적용되며, 당첨된 금액은 즉시 확인할 수 있습니다. 페이백 금액이 적용되더라도 영화 예매는 정상적으로 확정됩니다. 예매 취소 시 페이백 금액은 반환되지 않습니다. 불법적인 방법으로 당첨 시스템을 조작하거나 시도할 경우, 서비스 이용이 제한될 수 있습니다.
"""
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .justified
        return label
    }()

    // 버튼 StackView
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.alignment = .center
        return stackView
    }()

    //
    var disagreementButton: UIButton = {
        let button = UIButton()
        button.setTitle("비동의", for: .normal)
        button.backgroundColor = .lightGray
        button.setTitleColor(.darkGray, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    var agreementButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체 동의", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    // MARK: - 기본 설정

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 레이아웃 설정

    private func configureUI() {
        // 뷰에 추가
        [
            titleLable,
            serviceTermsTitleLabel,
            serviceTermsScrollView,
            randomTermsTitleLabel,
            randomTermsScrollView,
            buttonStackView
        ].forEach {
            self.addSubview($0)
        }

        // 서비스 이용약관 ScrillView에 추가
        serviceTermsScrollView.addSubview(serviceTermsTextLabel)

        // 랜덤 티켓 약관 ScrollView에 추가
        randomTermsScrollView.addSubview(randomTermsTextLabel)

        // 버튼 StackView에 추가
        [disagreementButton, agreementButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }

        let safeArea = self.safeAreaLayoutGuide // safeArea 변수 생성

        titleLable.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top).offset(30)
            $0.centerX.equalToSuperview()
        }

        serviceTermsTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLable.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(20)
        }

        serviceTermsScrollView.snp.makeConstraints {
            $0.top.equalTo(serviceTermsTitleLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(200)
        }

        serviceTermsTextLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.width.equalToSuperview().multipliedBy(0.95)
            $0.centerX.equalToSuperview()
        }

        randomTermsTitleLabel.snp.makeConstraints {
            $0.top.equalTo(serviceTermsScrollView.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(20)
        }

        randomTermsScrollView.snp.makeConstraints {
            $0.top.equalTo(randomTermsTitleLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(200)
        }

        randomTermsTextLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.width.equalToSuperview().multipliedBy(0.95)
            $0.centerX.equalToSuperview()
        }

        buttonStackView.snp.makeConstraints {
            $0.bottom.equalTo(safeArea.snp.bottom).inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        disagreementButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }

        agreementButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }
}

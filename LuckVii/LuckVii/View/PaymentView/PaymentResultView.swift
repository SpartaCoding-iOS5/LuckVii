//
//  PaymentResultView.swift
//  LuckVii
//
//  Created by 박민석 on 12/18/24.
//

import UIKit
import SnapKit

protocol gachaButtonDelegate: AnyObject {
    func didTapGachaButton()
}

class PaymentResultView: UIView {
    
    private let height =  UIScreen.main.bounds.height // 뷰의 세로 길이, 16pro 기준 874.0
    
    weak var delegate: gachaButtonDelegate?
    
    // 티켓 번호 레이블
    private let ticketNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "티켓 1 당첨 결과"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22)
        return label
    }()
    
    // 당첨 금액 레이블
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "🎉 축하드립니다! 30,000원 당첨!"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    // 좌석 번호 레이블
    private let seatLabel: UILabel = {
        let label = UILabel()
        label.text = "영등포 럭비관 1관 6층 (아이맥스) C9"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    // 안내 문구 레이블
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "차액은 바로 환불되오니 즐거운 관람 되세요! 🍿✨"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0 // 레이블 줄 수 무제한으로 설정
        label.lineBreakMode = .byWordWrapping   // 줄바꿈 모드 설정
        return label
    }()
    
    // 뽑기 버튼
    private let gachaButton: UIButton = {
        let button = UIButton()
        button.setTitle("티켓 뽑기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(gachaButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // UI 셋업 메서드
    private func setupUI() {
        [
            ticketNumberLabel,
            amountLabel,
            seatLabel,
            commentLabel,
            gachaButton
        ].forEach { addSubview($0) }
        
        ticketNumberLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(height / 3) // 전체 높이의 1/3 지점
            $0.centerX.equalToSuperview()
        }
        
        amountLabel.snp.makeConstraints{
            $0.top.equalTo(ticketNumberLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(32)
        }
        
        seatLabel.snp.makeConstraints{
            $0.top.equalTo(amountLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(32)
        }
        
        commentLabel.snp.makeConstraints{
            $0.top.equalTo(seatLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(32)
        }
        
        gachaButton.snp.makeConstraints{
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(50)
        }
    }
    
    // UI 값 접근 메서드
    func setUI(_ ticketNumer: Int, _ amount: String, _ seat: String) {
        ticketNumberLabel.text = "티켓 \(ticketNumer) 당첨 결과"
        amountLabel.text = "🎉 축하드립니다! \(amount)원 당첨!"
        seatLabel.text = "영등포 럭비관 1관 6층 (아이맥스) \(seat)"
    }
    
    @objc func gachaButtonTapped() {
        delegate?.didTapGachaButton()
    }
    
}

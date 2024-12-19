//
//  PaymentResultViewController.swift
//  LuckVii
//
//  Created by 박민석 on 12/18/24.
//

import UIKit

// 좌석 번호랑 할인 가격 랜덤으로 들어가게 하기
/*
 좌석 번호 A~Z + 1~49
 최종 금액 확률 (%)
 30,000원 5%
 25,000원 10%
 20,000원 30%
 15,000원 50%
 10,000원 10%
 5,000원 5%
 */
class PaymentResultViewController: UIViewController {
    
    let paymentResultView = PaymentResultView()
    
    var ticketNumber: Int = 0 // 티켓 번호

    var ticketCount: Int? // 티켓 갯수

    override func loadView() {
        self.view = paymentResultView
        doGatcha()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAction()

        //paymentResultView.delegate = self
    }

    // MARK: - 액션 연결

    private func setupAction() {
        paymentResultView.gachaButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.didTappedButton()
        }, for: .touchUpInside)
    }

    private func didTappedButton() {
        guard let ticketCount = ticketCount else { return }
        print(ticketCount, ticketNumber)
        if ticketNumber < ticketCount {
            doGatcha()
        } else {
            complete()
        }
    }

    // 좌석 번호 생성
    private func generateSeatCode() -> String {
        // 랜덤한 a~z 문자 생성
        let randomLetter = Character(UnicodeScalar(Int.random(in: 65...90))!)
        // 랜덤한 1~49 숫자 생성
        let randomNumber = Int.random(in: 1...49)
        // 대문자 알파벳과 숫자 합쳐서 반환
        return "\(randomLetter)\(randomNumber)"
    }
    
    // 당첨 금액 생성
    private func genratePrizeAmount() -> String {
        let randomValue = Int.random(in: 0..<100)
        let amount: Int
        
        switch randomValue {
        case 0..<5:    // 5%
            amount = 5000
        case 5..<15:   // 10%
            amount = 10000
        case 15..<65:  // 50%
            amount = 15000
        case 65..<95:  // 30%
            amount = 20000
        case 95..<100: // 5%
            amount = 30000
        default:
            amount = 0
        }
        
        // NumberFormatter를 사용해 금액 포맷 적용
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal // 천 단위 구분 기호 추가
        return formatter.string(from: NSNumber(value: amount)) ?? "0"
    }
    
    // '티켓 뽑기' 버튼 누를때마다 당첨금과 좌석 랜덤하게 변경
    private func doGatcha() {
        // 애니메이션 적용
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self = self else { return }
            // 1. 뷰를 화면 왼쪽으로 이동
            self.paymentResultView.transform = CGAffineTransform(translationX: -self.view.bounds.width, y: 0)
        }) { [weak self] _ in
            guard let self = self else { return }
            // 2. 새로운 값 설정
            let seat = self.generateSeatCode()
            let prize = self.genratePrizeAmount()
            self.ticketNumber += 1
            let isLastChance = ticketCount == ticketNumber // 마지막 기회인지 확인

            self.paymentResultView.setUI(self.ticketNumber, prize, seat, isLastChance)

            // 3. 뷰를 화면 오른쪽으로 이동
            self.paymentResultView.transform = CGAffineTransform(translationX: self.view.bounds.width, y: 0)
            
            // 4. 뷰를 원래 위치로 애니메이션
            UIView.animate(withDuration: 0.3) {
                self.paymentResultView.transform = .identity
            }
        }
    }

    // 티켓 뽑기 종료
    private func complete() {
        self.navigationController?.pushViewController(SearchViewController(), animated: true)
    }
}

// MARK: - 데이터 설정

extension PaymentResultViewController {

    // 데이터 전달 받는 메서드
    func configureData(data: Int) {
        ticketCount = data
    }
}

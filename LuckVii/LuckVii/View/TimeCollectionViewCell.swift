//
//  TimeCollectionViewCell.swift
//  LuckVii
//
//  Created by mun on 12/18/24.
//

import UIKit
import SnapKit

class TimeCollectionViewCell: UICollectionViewCell {

    private let view: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 0.8
        view.layer.cornerRadius = 7
        return view
    }()

    // 시간 라벨을 담는 View
    private let timeLabelView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    // 시작 시간 Label
    private let startTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 15)
        label.text = "14:24"
        return label
    }()

    // 시간 연결 Label
    private let timeConnectingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        label.text = "-"
        return label
    }()

    // 종료 시간 Label
    private let endTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 11)
        label.textColor = .darkGray
        label.text = "14:24"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 레이아웃 설정

    private func configureUI() {
        self.addSubview(view)

        [timeLabelView].forEach {
            view.addSubview($0)
        }

        [startTimeLabel, timeConnectingLabel, endTimeLabel].forEach {
            timeLabelView.addSubview($0)
        }

        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(180)
            $0.width.equalTo(200)
        }

        timeLabelView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
        }

        startTimeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.centerX.equalToSuperview()

        }

        timeConnectingLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        endTimeLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(6)
            $0.centerX.equalToSuperview()
        }
    }

    // MARK: - 데이터 설정

    func configureData(startTime: String, endTime: String, isSelected: Bool) {
        startTimeLabel.text = startTime
        endTimeLabel.text = endTime

        // 선택된 아이템인지 확인
        if isSelected {
            view.backgroundColor = .systemGreen
            startTimeLabel.textColor = .white
            timeConnectingLabel.textColor = .white
            endTimeLabel.textColor = .white
            view.layer.borderColor = UIColor.systemGreen.cgColor
        } else {
            view.backgroundColor = .white
            startTimeLabel.textColor = .black
            timeConnectingLabel.textColor = .black
            endTimeLabel.textColor = .black
            view.layer.borderColor = UIColor.gray.cgColor
        }
    }
}

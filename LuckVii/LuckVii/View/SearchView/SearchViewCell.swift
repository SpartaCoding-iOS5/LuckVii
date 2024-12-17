//
//  SearchViewCell.swift
//  LuckVii
//
//  Created by t2023-m0072 on 12/15/24.
//

import UIKit
import SnapKit

class SearchViewCell: UICollectionViewCell {
    
    // 영화포스터 이미지 뷰
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // 영화 이름 레이블
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = "영화 이름"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .label
        label.backgroundColor = .systemBackground
        return label
    }()
    
    // MARK: - 생성자
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI 셋업
    private func setupUI() {
        [
            movieImageView,
            movieNameLabel
        ].forEach { contentView.addSubview($0) }
        
        // 영화 이미지 레이아웃
        movieImageView.snp.makeConstraints{
            $0.top.equalTo(contentView.snp.top)
            $0.leading.trailing.equalTo(contentView)
            $0.width.equalTo(112)
            $0.height.equalTo(163)
        }
        
        // 영화 이름 레이아웃
        movieNameLabel.snp.makeConstraints{
            $0.top.equalTo(movieImageView.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(contentView)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-1)
        }
    }
    
    
    // MARK: - 이미지뷰, 레이블 값 변경 메서드
    func setCellData(_ dataSource: MovieDataSource) {
        if let image = dataSource.image {
            movieImageView.image = image
        } else {
            movieImageView.backgroundColor = .systemGray4
        }
        movieNameLabel.text = dataSource.movieData.title.isEmpty ? "영화 제목 없음" : dataSource.movieData.title
    }
}

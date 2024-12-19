//
//  MovieCollectionView.swift
//  LuckVii
//
//  Created by 박진홍 on 12/19/24.
//

import UIKit

final class MovieCollectionView: UICollectionView {
    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal//방향 설정
        layout.itemSize = CGSize(width: 120, height: 200)//포스터 사이즈 설정
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        return layout
    }()
    
    
    init() {
        super.init(frame: .zero, collectionViewLayout: layout)
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
    }
}

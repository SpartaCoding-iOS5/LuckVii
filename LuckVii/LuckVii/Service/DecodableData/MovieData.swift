//
//  MovieData.swift
//  LuckVii
//
//  Created by 박진홍 on 12/17/24.
//

import Foundation

struct MovieData: Decodable {//인코딩 될 일이 없기 때문에 디코더블로 준수
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int
    let title: String
    let genreIds: Array<Int>
    let adult: Bool//성인영화 여부
    let originalLanguage: String//영화 원래 언어
    let overview: String //설명
    let popularity: Double//인기도
    let posterPath: String?//포스터 > 없을 경우 대비 하여 옵셔널
    let title: String
}

// TODO:  genre id converte

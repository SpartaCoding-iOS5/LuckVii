//
//  VideoData.swift
//  LuckVii
//
//  Created by 박진홍 on 12/17/24.
//

struct VideoData: Decodable {
    let results: [Video]
}

struct Video: Decodable {
    let site: String
    let key: String
}


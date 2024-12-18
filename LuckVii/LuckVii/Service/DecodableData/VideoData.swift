//
//  VideoData.swift
//  LuckVii
//
//  Created by 박진홍 on 12/17/24.
//
import Foundation

struct VideoData: Decodable {//
    let results: [Video]
}

struct Video: Decodable {
    let site: String
    let key: String
}

extension Video {
    func getVideoURL() -> URL? {
        let baseURL: String = "https://www.youtube.com/watch?v="
        return URL(string: baseURL + key)
    }
}


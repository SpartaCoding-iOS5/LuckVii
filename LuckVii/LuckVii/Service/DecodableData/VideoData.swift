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
    func getVideoURL() throws -> URL {
        let baseURL: String = "https://www.youtube.com/watch?v="
        
        if site != "YouTube" { throw AppError.convertError(.URLMakingError) }
        
        guard let url =  URL(string: baseURL + key) else {
            throw AppError.convertError(.URLMakingError)
        }
        
        return url
    }
}


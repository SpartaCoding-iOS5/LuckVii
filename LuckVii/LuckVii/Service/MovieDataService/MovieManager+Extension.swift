//
//  MovieManager+Extension.swift
//  LuckVii
//
//  Created by 박진홍 on 12/17/24.
//

typealias URLParameters = [String: String]

extension MovieDataManager {
    enum URLParameterSet {
        static let basic: URLParameters = ["language": "ko-KR", "page": "1"]
        
        static func custom(parameters: URLParameters) -> URLParameters {
            return parameters
        }
    }
    
    enum URLEndpointSet: String {
        case nowPlaying = "/now_playing"
        case popular = "/popular"
        case upcoming = "/upcoming"
    }
}

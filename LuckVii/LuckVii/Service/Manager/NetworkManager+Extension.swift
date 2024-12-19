//
//  MovieManager+Extension.swift
//  LuckVii
//
//  Created by 박진홍 on 12/17/24.
//

typealias URLParameters = [String: String]

extension NetworkManager {
    enum URLParameterSet {
        static let empty: URLParameters = [:]
        static let common: URLParameters = ["language": "ko-KR", "page": "1"]
        static let secondPage: URLParameters = ["language": "ko-KR", "page": "2"]

        static func custom(parameters: URLParameters) -> URLParameters {
            return parameters
        }
    }

    enum URLEndpointSet: RawRepresentable {
        case nowPlaying
        case popular
        case upcoming
        case detail(id: Int)
        case video(id: Int)
        case custom(path: String)

        var rawValue: String {
            switch self {
            case .nowPlaying:
                return "/now_playing"
            case .popular:
                return "/popular"
            case .upcoming:
                return "/upcoming"
            case .detail(let id):
                return "/\(String(id))"
            case .video(let id):
                return "/\(String(id))/videos"
            case .custom(let path):
                return path
            }
        }

        init?(rawValue: String) {
            switch rawValue {
            case "/now_playing":
                self = .nowPlaying
            case "/popular":
                self = .popular
            case "/upcoming":
                self = .upcoming
            default:
                self = .custom(path: rawValue)
            }
        }

    }
}

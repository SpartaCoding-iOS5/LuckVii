//
//  MovieManager+Extension.swift
//  LuckVii
//
//  Created by 박진홍 on 12/17/24.
//

typealias URLParameters = Dictionary<String, String>

extension NetworkManager {
    enum URLParameterSet {
        static let empty: URLParameters = [:]
        static let common: URLParameters = ["language": "ko-KR", "page": "1"]
        
        static func custom(parameters: URLParameters) -> URLParameters {
            return parameters
        }
    }
    
    enum URLEndpointSet: RawRepresentable {
        case nowPlaying /*= "/now_playing"*/
        case popular /*= "/popular"*/
        case upcoming /*= "/upcoming"*/
        case video(id: Int) /*= "/\(String(id))/videos"*/
        case custom(path: String)
        
        var rawValue: String {
            switch self {
            case .nowPlaying:
                return "/now_playing"
            case .popular:
                return "popular"
            case .upcoming:
                return "upcoming"
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

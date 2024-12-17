//
//  VideoManager.swift
//  LuckVii
//
//  Created by 박진홍 on 12/17/24.
//

//youtube url https://www.youtube.com/watch?v=/

import Foundation

final class VideoManager {
    static let shared: VideoManager = VideoManager()
    private let successRange: Range = (200..<300)
    private let baseURL: String = "https://api.themoviedb.org/3/movie/"//기본 url
    private let apiKey: String = "b73e6f73276501cdee3491a188cf2e93"//api 요청 키
    private let baseYoutubeURL: String = "https://www.youtube.com/watch?v=/"
    
    private init() {}
    
    func fetchVideoURL(
        id: Int
    ) async throws -> URL? {
        guard let url = URL(string: "\(baseURL)\(String(id))/videos?api_key=\(apiKey)") else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
        
        guard let response = response as? HTTPURLResponse,
              successRange.contains(response.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let videoData = try decoder.decode(VideoData.self, from: data)
            guard let key = videoData.results.first?.key else {
                throw NetworkError.noData
            }
            return URL(string: baseYoutubeURL+key)
        } catch {
            throw NetworkError.decodingError
        }
    }
}

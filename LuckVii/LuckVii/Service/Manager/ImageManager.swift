//
//  ImageManager.swift
//  LuckVii
//
//  Created by 박진홍 on 12/17/24.
//

//이미지 요청 베이스 url https://image.tmdb.org/t/p/사이즈/이미지path
//이미지 사이즈는 w92, w154, w185, w342, w500, w780 등과 original 있음

import UIKit
import Foundation

final class ImageManager {
    static let shared = ImageManager()
    
    private let cache: NSCache<NSURL, UIImage> = {
        let cache = NSCache<NSURL, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    private let baseURL: String = "https://image.tmdb.org/t/p"
    private let successRange: Range = (200..<300)
    
    private init() {}
    
    // MARK: - await만을 활용한 개선된 메서드
    
    func fetchImage(
        from path: String,
        size: ImageWidth
    ) async throws -> UIImage? {
        guard let url: URL = URL(string: "\(baseURL)\(size.rawValue)\(path)") else {
            throw NetworkError.invalidURL
        }
        
        if let image = cache.object(forKey: url as NSURL) {//cache된 이미지가 있으면 사용
            return image
        }
        
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
        
        guard let response = response as? HTTPURLResponse,
              successRange.contains(response.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        guard let image = UIImage(data: data) else {
            throw NetworkError.decodingError
        }
        
        cache.setObject(image, forKey: url as NSURL)
        
        return image
    }
}

// MARK: - image width에 관한 enum

extension ImageManager {
    enum ImageWidth: String {
        case w92 = "/w92"
        case w154 = "/w154"
        case w185 = "/w185"
        case w342 = "/w342"
        case w500 = "/w500"
        case w780 = "/w780"
        case original = "/original"
    }
}

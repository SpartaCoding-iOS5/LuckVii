//
//  NetworkError.swift
//  LuckVii
//
//  Created by 박진홍 on 12/17/24.
//

enum AppError: Error {
    case networkError(NetworkError)
    case convertError(ConvertError)
    
    enum NetworkError: Error {
        case invalidURL
        case noData
        case decodingError
        case networkError(String)
        case invalidResponse
    }
    
    enum ConvertError: Error {
        case dateFormattingError
        case URLMakingError
    }
}





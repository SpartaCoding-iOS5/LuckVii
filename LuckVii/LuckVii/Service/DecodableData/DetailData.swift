//
//  DetailData.swift
//  LuckVii
//
//  Created by 박진홍 on 12/18/24.
//
import Foundation

struct DetailData: Decodable {
    let releaseDate: String
    let runtime: Int
    let adult: Bool // 추가함. 없으면 영화 세부화면에서 표시되지않음
}

extension DetailData {
    // 날짜 포맷을 처리하면서 throw를 사용하여 에러 던짐
    func getReleaseDate() throws -> Date {
        guard let date = DateFormatter.yyyyMmDdFormatter.date(from: releaseDate) else {
            // 날짜 파싱 실패 시 error 던짐
            throw AppError.convertError(.dateFormattingError)
        }
        
        return date
    }
}

extension DateFormatter {
    static var yyyyMmDdFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
}

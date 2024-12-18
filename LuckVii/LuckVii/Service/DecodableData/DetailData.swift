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
    func getReleaseDate() -> Date? {
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-mm-dd"
            return formatter
        }()
        
        return dateFormatter.date(from: releaseDate)
    }
}

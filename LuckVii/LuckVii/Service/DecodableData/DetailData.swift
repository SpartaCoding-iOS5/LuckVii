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

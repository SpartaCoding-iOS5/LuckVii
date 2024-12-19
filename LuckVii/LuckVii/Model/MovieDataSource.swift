//
//  MovieDataSource.swift
//  LuckVii
//
//  Created by 박진홍 on 12/19/24.
//

import UIKit

struct MovieDataSource {
    let movieData: Movie
    let image: UIImage?
    
    func setMovieData(movie: Movie) -> MovieDataSource {
        return MovieDataSource(movieData: movie, image: self.image)
    }
}

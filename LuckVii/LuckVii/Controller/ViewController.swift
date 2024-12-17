//
//  ViewController.swift
//  LuckVii
//
//  Created by 손겸 on 12/16/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        view.backgroundColor = .black
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        foo()
    }


}

extension ViewController {
    private func foo() {
        var movies: MovieData = MovieData(results: [])
        let parameters: URLParameters = NetworkManager.URLParameterSet.common
        Task {
            do {
                movies = try await NetworkManager.shared.fetchData(endpoint: .nowPlaying, parameters: parameters)
                print(movies.results[3].title)
            } catch {
                print("너 에러남 메롱")
            }
            
            let id = movies.results[3].id
            let parameterForVideo: URLParameters = [:]
            var movie: VideoData = VideoData(results: [])
            Task {
                do {
                    movie = try await NetworkManager.shared.fetchData(endpoint: .video(id: id), parameters: parameterForVideo)
                    print(movie.results[0].key)
                }
            }
        }
    }
}

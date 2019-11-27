//
//  APIMovieDetail.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/25/19.
//  Copyright © 2019 huy. All rights reserved.
//

import ObjectMapper

extension API {
    func getMovieDetail(_ input: GetMovieDetailInput) -> Observable<MovieDetail> {
        return request(input)
    }
}

extension API {
    final class GetMovieDetailInput: APIInput {
        init(idMovie: Int) {
            let param: JSONDictionary = [
                "append_to_response": "videos"
            ]
            super.init(
                urlString: APIUrl.movieDetailUrl + "\(idMovie)",
                parameters: param,
                requestType: .get,
                requireAccessToken: false)
        }
    }
}

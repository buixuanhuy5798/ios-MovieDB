//
//  APIActor.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/26/19.
//  Copyright © 2019 huy. All rights reserved.
//

import ObjectMapper

extension API {
    func getActorOfMovie(_ input: GetActorOfMovieInput) -> Observable<GetActorOfMovieOutput> {
        return request(input)
    }
}

extension API {
    final class GetActorOfMovieInput: APIInput {
        init(idMovie: Int) {
            super.init(
                urlString: APIUrl.movieDetailUrl + "\(idMovie)/credits",
                parameters: nil,
                requestType: .get,
                requireAccessToken: false)
        }
    }
    
    final class GetActorOfMovieOutput: APIOutput {
        private(set) var actors: [Actor]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            actors <- map["cast"]
        }
    }
}

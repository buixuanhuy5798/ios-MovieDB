//
//  APINowPlaying.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/13/19.
//  Copyright © 2019 huy. All rights reserved.
//

import ObjectMapper

extension API {
    func getNowPlaying(_ input: GetNowPlayingInput) -> Observable<GetNowPlayingOutput> {
        return request(input)
    }
}

extension API {
    final class GetNowPlayingInput: APIInput {
        init(page: Int) {
            let param: JSONDictionary = [
                "page": page
            ]
            super.init(urlString: API.APIUrl.nowPlayingUrl,
                       parameters: param,
                       requestType: .get,
                       requireAccessToken: false)
        }
    }
    
    final class GetNowPlayingOutput: APIOutput {
        private(set) var nowPlaying: [NowPlaying]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            nowPlaying <- map["results"]
        }
    }
}

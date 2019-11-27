//
//  MovieDetail.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/26/19.
//  Copyright © 2019 huy. All rights reserved.
//

import ObjectMapper

struct MovieDetail {
    var id: Int
    var title: String
    var backdropPath: String
    var posterPath: String
    var overview: String
    var voteCount: Int
    var voteAverage: Float
    var runTime: Int
    var videos: Videos
    var posterImageUrl: String {
        return API.APIUrl.backdropUrl + posterPath
    }
    var backdropImageUrl: String {
        return API.APIUrl.backdropUrl + backdropPath
    }
    var keyYoutubeTrailer: String? {
        guard let key = videos.videos.first?.key else {
            return nil
        }
        return key
    }
}

extension MovieDetail {
    init() {
        self.init(id: 0, title: "",
                  backdropPath: "", posterPath: "",
                  overview: "", voteCount: 0,
                  voteAverage: 0, runTime: 0,
                  videos: Videos())
    }
}

extension MovieDetail: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        backdropPath <- map["backdrop_path"]
        posterPath <- map["poster_path"]
        overview <- map["overview"]
        voteCount <- map["vote_count"]
        voteAverage <- map["vote_average"]
        runTime <- map["runtime"]
        videos <- map["videos"]
    }
}

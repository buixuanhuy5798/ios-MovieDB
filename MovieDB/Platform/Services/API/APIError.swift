//
//  APIError.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 10/29/19.
//  Copyright © 2019 huy. All rights reserved.
//

struct APIExpiredTokenError: APIError {
    var errorDescription: String? {
        return NSLocalizedString("api.expiredTokenError",
                                 value: "Access token is expired",
                                 comment: "")
    }
}

struct APIResponseError: APIError {
    let statusCode: Int?
    let statusMessage: String
    
    var errorDescription: String? {
        return statusMessage
    }
}

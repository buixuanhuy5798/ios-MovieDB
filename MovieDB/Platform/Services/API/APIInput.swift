//
//  APIInput.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 10/29/19.
//  Copyright © 2019 huy. All rights reserved.
//

import Alamofire

class APIInput: APIInputBase {
    override init(urlString: String,
                  parameters: [String: Any]?,
                  requestType: HTTPMethod,
                  requireAccessToken: Bool) {        
        super.init(urlString: urlString,
                   parameters: parameters,
                   requestType: requestType,
                   requireAccessToken: requireAccessToken)
        self.headers = [
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json"
        ]
    }
}

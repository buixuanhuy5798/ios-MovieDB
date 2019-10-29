//
//  APIService.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 10/29/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class API: APIBase {
    static var shared = API()
    
    override func handleResponseError(response: HTTPURLResponse, data: Data, json: JSONDictionary?) -> Error {
        if let json = json, let message = json["status_message"] as? String {
            return APIResponseError(statusCode: response.statusCode, statusMessage: message)
        }
        return super.handleResponseError(response: response, data: data, json: json)
    }
    
    override func preprocess(_ input: APIInputBase) -> Observable<APIInputBase> {
        var params = input.parameters ?? [:]
        params["api_key"] = APIKey.apiKey
        return super.preprocess(APIInputBase(urlString: input.urlString,
                                             parameters: params,
                                             requestType: input.requestType,
                                             requireAccessToken: input.requireAccessToken))
    }
}


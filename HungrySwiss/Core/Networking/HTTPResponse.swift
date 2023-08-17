//
//  HTTPResponse.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 17/08/2023.
//

import Foundation

enum HTTPResponseError: Error {
    case missingBody
}

struct HTTPResponse {
    let body: Data?
}

extension HTTPResponse {
    
    func decodeBody<T>(
        _ bodyType: T.Type,
        jsonDecoder: JSONDecoder = JSONDecoder()
    ) throws -> T where T: Decodable {
        guard let body else {
            throw HTTPResponseError.missingBody
        }
        
        return try jsonDecoder.decode(bodyType, from: body)
    }
    
}

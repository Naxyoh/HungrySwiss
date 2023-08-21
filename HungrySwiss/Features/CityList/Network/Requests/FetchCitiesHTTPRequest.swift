//
//  FetchCitiesHTTPRequest.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 20/08/2023.
//

import Foundation

struct FetchCitiesHTTPRequest: HTTPRequest {
    var method: HTTPMethod {
        .get
    }
    
    var path: String {
        "/cities"
    }
    
    var queryParameters: [String : String] {
        [:]
    }
    
}

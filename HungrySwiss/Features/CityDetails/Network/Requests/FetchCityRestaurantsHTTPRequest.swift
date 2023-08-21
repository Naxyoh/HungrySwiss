//
//  FetchCityRestaurantsHTTPRequest.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 21/08/2023.
//

import Foundation

struct FetchCityRestaurantsHTTPRequest: HTTPRequest {
    var method: HTTPMethod {
        .get
    }
    
    var path: String {
        "/city/\(cityID)"
    }
    
    var queryParameters: [String : String] {
        [:]
    }
    
    private let cityID: String
    
    init(cityID: String) {
        self.cityID = cityID
    }
    
}

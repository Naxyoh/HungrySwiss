//
//  HTTPRequest.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 17/08/2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol HTTPRequest {
    var method: HTTPMethod { get }
    var path: String { get }
    var queryParameters: [String: String] { get }
}

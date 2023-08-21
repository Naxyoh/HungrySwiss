//
//  HTTPProvider.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 17/08/2023.
//

import Foundation

protocol HTTPProvider {
    func send(_ request: HTTPRequest) async throws -> HTTPResponse
}

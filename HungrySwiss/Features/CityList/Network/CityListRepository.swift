//
//  CityListRepository.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 20/08/2023.
//

import Foundation

protocol CityListRepositoryProtocol {
    func fetchCities() async throws -> FetchCitiesResponseDTO
}

struct CityListRepository: CityListRepositoryProtocol {
    
    private let httpProvider: HTTPProvider
    
    init(httpProvider: HTTPProvider) {
        self.httpProvider = httpProvider
    }
    
    func fetchCities() async throws -> FetchCitiesResponseDTO {
        let request = FetchCitiesHTTPRequest()
        
        let response = try await httpProvider.send(request)
        return try response.decodeBody(FetchCitiesResponseDTO.self)
    }
}

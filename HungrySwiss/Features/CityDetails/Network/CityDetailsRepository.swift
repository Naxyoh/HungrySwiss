//
//  CityDetailsRepository.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 21/08/2023.
//

import Foundation

protocol CityDetailsRepositoryProtocol {
    func fetchCityRestaurants(cityID: String) async throws -> FetchCityRestaurantsResponseDTO
}

struct CityDetailsRepository: CityDetailsRepositoryProtocol {
    
    private let httpProvider: HTTPProvider
    
    init(httpProvider: HTTPProvider) {
        self.httpProvider = httpProvider
    }
    
    func fetchCityRestaurants(cityID: String) async throws -> FetchCityRestaurantsResponseDTO {
        let request = FetchCityRestaurantsHTTPRequest(cityID: cityID)
        
        let response = try await httpProvider.send(request)
        return try response.decodeBody(FetchCityRestaurantsResponseDTO.self)
    }
}

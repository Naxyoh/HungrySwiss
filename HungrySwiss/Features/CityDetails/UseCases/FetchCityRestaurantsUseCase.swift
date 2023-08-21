//
//  FetchCityRestaurantsUseCase.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 21/08/2023.
//

import Foundation

protocol FetchCityRestaurantsUseCaseProtocol {
    func invoke(cityID: String) async throws -> FetchCityRestaurantsResponseDTO
}

struct FetchCityRestaurantsUseCase: FetchCityRestaurantsUseCaseProtocol {
    
    private let citiesRepository: CityDetailsRepositoryProtocol
    
    init(citiesRepository: CityDetailsRepositoryProtocol) {
        self.citiesRepository = citiesRepository
    }
    
    func invoke(cityID: String) async throws -> FetchCityRestaurantsResponseDTO {
        let response = try await citiesRepository.fetchCityRestaurants(cityID: cityID)
        return response
    }
}

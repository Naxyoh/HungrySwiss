//
//  FetchCitiesUseCase.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 20/08/2023.
//

import Foundation

protocol FetchCitiesUseCaseProtocol {
    func invoke() async throws -> [CityDTO]
}

struct FetchCitiesUseCase: FetchCitiesUseCaseProtocol {
    
    private let citiesRepository: CityListRepositoryProtocol
    
    init(citiesRepository: CityListRepositoryProtocol) {
        self.citiesRepository = citiesRepository
    }
    
    func invoke() async throws -> [CityDTO] {
        let response = try await citiesRepository.fetchCities()
        return response.cities
    }
}

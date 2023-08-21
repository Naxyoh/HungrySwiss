//
//  CityDetailsViewModel.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 21/08/2023.
//

import Foundation

final class CityDetailsViewModel {
    
    // MARK: - Public Properties
    
    var cityName: String {
        city.channelInfo.title
    }
    
    // MARK: - Private Properties
    
    private let fetchCityRestaurantsUseCase: FetchCityRestaurantsUseCaseProtocol
    
    private let city: CityDTO
    
    // MARK: - Initialization Methods
    
    init(
        city: CityDTO,
        fetchCityRestaurantsUseCase: FetchCityRestaurantsUseCaseProtocol
    ) {
        self.city = city
        self.fetchCityRestaurantsUseCase = fetchCityRestaurantsUseCase
    }
    
}

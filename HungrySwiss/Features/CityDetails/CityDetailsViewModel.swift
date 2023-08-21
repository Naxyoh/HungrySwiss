//
//  CityDetailsViewModel.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 21/08/2023.
//

import Foundation
import Combine

final class CityDetailsViewModel {
    
    enum Item {
        case addressPicker(CityDTO)
        case theme(FacetCategoryDTO)
        case restaurant(RestaurantDTO)
    }
    
    struct Section {
        var items: [Item]
        let sectionType: SectionType
    }
    
    enum SectionType: CaseIterable {
        case addressPicker
        case theme
        case restaurant
    }
    
    // MARK: - Public Properties
    
    var cityName: String {
        city.channelInfo.title
    }
    
    @Published var sections = [Section]()
    
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
    
    // MARK: - Public Methods
    
    func fetchCities() {
        Task {
            do {
                let response = try await fetchCityRestaurantsUseCase.invoke(cityID: city.id)
                
                await MainActor.run {
                    self.sections = [
                        .init(items: [.addressPicker(city)], sectionType: .addressPicker),
                        .init(items: response.facetCategories.map(Item.theme), sectionType: .theme),
                        .init(items: response.items.map(Item.restaurant), sectionType: .restaurant),
                    ]
                }
            } catch {
                print(error)
            }
        }
    }
    
}

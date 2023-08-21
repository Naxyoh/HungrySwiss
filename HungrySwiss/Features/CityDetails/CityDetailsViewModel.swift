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
        case restaurant(RestaurantDTO, isOpened: Bool)
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
                
                let restaurantItems = response.items.map { restaurant in
                    Item.restaurant(restaurant, isOpened: isRestaurantOpened(restaurant))
                    
                }
                
                await MainActor.run {
                    self.sections = [
                        .init(items: [.addressPicker(city)], sectionType: .addressPicker),
                        .init(items: response.facetCategories.map(Item.theme), sectionType: .theme),
                        .init(items: restaurantItems, sectionType: .restaurant),
                    ]
                }
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func isRestaurantOpened(_ restaurant: RestaurantDTO) -> Bool {
        let currentHour = Calendar.current.component(.hour, from: Date())
        
        let openingHours = restaurant.openingHours
            .compactMap { mixedHours -> Range<Int>? in
                let hours = Array(mixedHours.split(separator: "-"))

                guard hours.count == 2 else {
                    return nil
                }

                guard
                    let openingAt = hours.first.map(String.init).flatMap(Int.init),
                    let closingAt = hours.last.map(String.init).flatMap(Int.init)
                else {
                    return nil
                }

                return (openingAt..<closingAt)
            }
        
        return openingHours.first(where: { $0.contains(currentHour) }) != nil
    }
    
}

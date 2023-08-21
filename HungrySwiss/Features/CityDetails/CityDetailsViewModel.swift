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
    
    var currentFilter: FacetCategoryDTO?
    
    private(set) var availableCities: [CityDTO]
    
    // MARK: - Private Properties
    
    private let fetchCityRestaurantsUseCase: FetchCityRestaurantsUseCaseProtocol
    
    private var city: CityDTO
    
    private var exhaustiveRestaurants: [RestaurantDTO] = []
    
    // MARK: - Initialization Methods
    
    init(
        city: CityDTO,
        availableCities: [CityDTO],
        fetchCityRestaurantsUseCase: FetchCityRestaurantsUseCaseProtocol
    ) {
        self.city = city
        self.availableCities = availableCities
        self.fetchCityRestaurantsUseCase = fetchCityRestaurantsUseCase
    }
    
    // MARK: - Public Methods
    
    func fetchRestaurants() {
        Task { [weak self] in
            guard let self else { return }
            
            do {
                let response = try await fetchCityRestaurantsUseCase.invoke(cityID: city.id)
                
                let restaurantItems = response.items.map { restaurant in
                    Item.restaurant(restaurant, isOpened: self.isRestaurantOpened(restaurant))
                }
                self.exhaustiveRestaurants = response.items
                
                await MainActor.run {
                    guard restaurantItems.isEmpty == false else {
                        self.sections = []
                        return
                    }
                    
                    self.sections = [
                        .init(items: [.addressPicker(self.city)], sectionType: .addressPicker),
                        .init(items: response.facetCategories.map(Item.theme), sectionType: .theme),
                        .init(items: restaurantItems, sectionType: .restaurant),
                    ]
                }
            } catch {
                print(error)
            }
        }
    }
    
    func filterRestaurants(by filter: FacetCategoryDTO) {
        let isFilterActive = filter.id != currentFilter?.id
        currentFilter = isFilterActive ? filter : nil
        
        let filteredRestaurants = exhaustiveRestaurants
            .filter { restaurant in
                return restaurant.myThemes.contains(filter.id)
            }
        
        guard let sectionIndexToInsertRestaurants = sections.firstIndex(where: { $0.sectionType == .restaurant }) else {
            return
        }
        
        let restaurantItems = (isFilterActive ? filteredRestaurants : exhaustiveRestaurants)
            .map { restaurant in
                Item.restaurant(restaurant, isOpened: self.isRestaurantOpened(restaurant))
            }
        sections[sectionIndexToInsertRestaurants] = .init(items: restaurantItems, sectionType: .restaurant)
    }
    
    func updateCity(_ newCity: CityDTO) {
        city = newCity
        fetchRestaurants()
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

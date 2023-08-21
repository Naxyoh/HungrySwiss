//
//  CityListViewModel.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 20/08/2023.
//

import Foundation
import Combine

final class CityListViewModel {
    
    enum Item {
        case addressPicker
        case city(CityDTO)
        case ads
    }
    
    struct Section {
        var title: String?
        var items: [Item]
        let sectionType: SectionType
    }
    
    enum SectionType: CaseIterable {
        case addressPicker
        case nearbyCities
        case ads
    }
    
    // MARK: - Private Properties
    
    private let fetchCitiesUseCase: FetchCitiesUseCaseProtocol
    private let cityListCoordinator: CityListCoordinator
    
    private var allCities = [CityDTO]()
    
    // MARK: - Public Properties
    
    @Published var sections: [Section] = []
    
    init(
        fetchCitiesUseCase: FetchCitiesUseCaseProtocol,
        cityListCoordinator: CityListCoordinator
    ) {
        self.fetchCitiesUseCase = fetchCitiesUseCase
        self.cityListCoordinator = cityListCoordinator
    }
    
    // MARK: - Public Methods
    
    func fetchCities() {
        Task {
            do {
                let cities = try await fetchCitiesUseCase.invoke()
                allCities = cities
                await MainActor.run {
                    self.sections = [
                        .init(items: [.addressPicker], sectionType: .addressPicker),
                        .init(items: cities.map(Item.city), sectionType: .nearbyCities),
                        .init(items: [.ads], sectionType: .ads),
                    ]
                }
            } catch {
                print(error)
            }
        }
    }
    
    func navigateToCityRestaurant(city: CityDTO) {
        cityListCoordinator.navigateToCityRestaurants(city: city, allCities: allCities)
    }
    
}

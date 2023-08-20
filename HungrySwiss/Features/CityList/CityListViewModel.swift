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
    
    // MARK: - Public Properties
    
    @Published var sections: [Section] = []
    
    init(fetchCitiesUseCase: FetchCitiesUseCaseProtocol) {
        self.fetchCitiesUseCase = fetchCitiesUseCase
    }
    
    // MARK: - Public Methods
    
    func fetchCities() {
        Task {
            do {
                let cities = try await fetchCitiesUseCase.invoke()
                
                await MainActor.run {
                    self.sections = [
                        .init(items: [.addressPicker], sectionType: .addressPicker),
                        .init(items: cities.map(Item.city), sectionType: .nearbyCities)
                    ]
                }
            } catch {
                print(error)
            }
            
        }
    }
    
}

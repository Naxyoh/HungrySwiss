//
//  CityListViewModel.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 20/08/2023.
//

import Foundation

final class CityListViewModel {
    
    enum Item {
        case addressPicker
        case city
        case ads
    }
    
    struct Section {
        var title: String?
        var items: [Item]
    }
    
}

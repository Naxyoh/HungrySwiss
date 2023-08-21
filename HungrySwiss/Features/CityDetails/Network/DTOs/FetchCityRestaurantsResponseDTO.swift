//
//  FetchCityRestaurantsResponseDTO.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 21/08/2023.
//

import Foundation

struct FetchCityRestaurantsResponseDTO: Decodable {
    
    let id: String
    let name: String
    let items: [RestaurantDTO]
    let facetCategories: [FacetCategoryDTO]
}

struct RestaurantDTO: Decodable {
    let id: String
    let title: String
    let subtitle: String
    let openingHours: [String]
    let images: RestaurantImagesDTO
    let myThemes: [String]
}

struct FacetCategoryDTO: Decodable {
    let id: String
    let label: String
    let icon: String
    let count: Int
}

struct RestaurantImagesDTO: Decodable {
    let cover: String
}

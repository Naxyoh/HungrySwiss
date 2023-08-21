//
//  FetchCitiesResponseDTO.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 20/08/2023.
//

import Foundation

struct FetchCitiesResponseDTO: Decodable {
    let cities: [CityDTO]
}

struct CityDTO: Decodable {
    let id: String
    let channelInfo: ChannelInformationDTO
}

struct ChannelInformationDTO: Decodable {
    let title: String
    let images: ChannelInformationImagesDTO
}

struct ChannelInformationImagesDTO: Decodable {
    let small: String
    let large: String
}

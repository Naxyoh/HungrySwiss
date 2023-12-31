//
//  CityDetailsCollectionViewDataSource.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 21/08/2023.
//

import UIKit

final class CityDetailsCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var sections: [CityDetailsViewModel.Section] = []
    var activeFilter: FacetCategoryDTO?
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = sections[indexPath.section].items[indexPath.row]
        
        switch item {
        case .addressPicker(let city):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CityListAddressPickerCollectionViewCell.reuseIdentifer,
                for: indexPath
            )
            (cell as? CityListAddressPickerCollectionViewCell)?.title = city.channelInfo.title
            (cell as? CityListAddressPickerCollectionViewCell)?.subtitle = "Tap here to change the address"

            return cell
        case .theme(let theme):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CityDetailsThemeCollectionViewCell.reuseIdentifer,
                for: indexPath
            )
            if let themeCell = cell as? CityDetailsThemeCollectionViewCell {
                themeCell.themeImageURLString = theme.icon
                themeCell.themeTitle = theme.label
                themeCell.isActive = (theme.id == activeFilter?.id)
                themeCell.hightlightView.layer.cornerRadius = themeCell.hightlightView.frame.width / 2
            }
            
            return cell
        case .restaurant(let restaurant, let isOpened):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CityDetailsRestaurantCollectionViewCell.reuseIdentifer,
                for: indexPath
            )
            
            if let restaurantCell = cell as? CityDetailsRestaurantCollectionViewCell {
                restaurantCell.coverImageURLString = restaurant.images.cover
                restaurantCell.restaurantTitle = restaurant.title
                restaurantCell.restaurantSubtitle = restaurant.subtitle
                restaurantCell.isRestaurantOpen = isOpened
            }
            
            return cell
        }
    }
    
}

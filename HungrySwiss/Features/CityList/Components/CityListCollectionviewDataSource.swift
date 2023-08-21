//
//  CityListCollectionviewDataSource.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 20/08/2023.
//

import UIKit

final class CityListCollectionviewDataSource: NSObject, UICollectionViewDataSource {
    
    var sections: [CityListViewModel.Section] = []
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = sections[indexPath.section].items[indexPath.row]
        
        switch item {
        case .addressPicker:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CityListAddressPickerCollectionViewCell.reuseIdentifer,
                for: indexPath
            )
            (cell as? CityListAddressPickerCollectionViewCell)?.title = "Hungry? We deliver!"
            (cell as? CityListAddressPickerCollectionViewCell)?.subtitle = "Tap here to select an address"

            return cell
        case .city(let city):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CityListCityCollectionViewCell.reuseIdentifer,
                for: indexPath
            )
            (cell as? CityListCityCollectionViewCell)?.cityImageURLString = city.channelInfo.images.small
            (cell as? CityListCityCollectionViewCell)?.cityName = city.channelInfo.title.uppercased()
            
            return cell
        case .ads:
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: CityListAdsCollectionViewCell.reuseIdentifer,
                for: indexPath
            )
        }
    }
    
}

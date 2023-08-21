//
//  CityListCollectionViewDelegate.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 21/08/2023.
//

import UIKit

final class CityListCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    var sections: [CityListViewModel.Section] = []
    
    var didSelectCity: ((CityDTO) -> ())?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        guard case .nearbyCities = section.sectionType else {
            return
        }
        
        guard case .city(let city) = section.items[indexPath.row] else {
            return
        }
        
        didSelectCity?(city)
    }
    
}

//
//  CityDetailsCollectionViewDelegate.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 21/08/2023.
//

import UIKit

final class CityDetailsCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    var didSelectFilter: ((FacetCategoryDTO) -> Void)?
    var didSelectAddressPicker: (() -> Void)?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let datasource = collectionView.dataSource as? CityDetailsCollectionViewDataSource else {
            return
        }
        
        let section = datasource.sections[indexPath.section]
        
        switch section.sectionType {
        case .theme:
            guard case .theme(let filter) = section.items[indexPath.row] else {
                return
            }
            
            didSelectFilter?(filter)
            
            datasource.activeFilter = (datasource.activeFilter?.id == filter.id) ? nil : filter
        case .addressPicker:
            didSelectAddressPicker?()
        case .restaurant:
            return
        }
    }
    
}

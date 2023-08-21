//
//  CityDetailsCollectionViewDelegate.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 21/08/2023.
//

import UIKit

final class CityDetailsCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    var didSelectFilter: ((FacetCategoryDTO) -> ())?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let datasource = collectionView.dataSource as? CityDetailsCollectionViewDataSource else {
            return
        }
        
        let section = datasource.sections[indexPath.section]
        guard case .theme = section.sectionType else {
            return
        }
        
        guard case .theme(let filter) = section.items[indexPath.row] else {
            return
        }
        
        didSelectFilter?(filter)
    }
    
}

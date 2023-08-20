//
//  CityListAddressPickerCollectionViewCell.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 20/08/2023.
//

import UIKit

final class CityListAddressPickerCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifer = "CityListAddressPickerCollectionViewCell"

    override init(frame: CGRect) {
      super.init(frame: frame)
      configureView()
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = .blue
    }
    
}

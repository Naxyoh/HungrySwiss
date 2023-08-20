//
//  CityListAdsCollectionViewCell.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 21/08/2023.
//

import UIKit

final class CityListAdsCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifer = "CityListAdsCollectionViewCell"
    
    // MARK: - UI Properties
    
    private let adsImageView = UIImageView()
    
    // MARK: - Initialization Methods

    override init(frame: CGRect) {
      super.init(frame: frame)
      configureView()
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configureView() {
        adsImageView.contentMode = .scaleAspectFit
        adsImageView.image = UIImage(named: "ads")
        
        addSubview(adsImageView)
        adsImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            adsImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            adsImageView.topAnchor.constraint(equalTo: topAnchor),
            adsImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            adsImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}


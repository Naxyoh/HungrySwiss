//
//  CityListCityCollectionViewCell.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 20/08/2023.
//

import UIKit
import SDWebImage

final class CityListCityCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifer = "CityListCityCollectionViewCell"
    
    // MARK: - UI Properties
    
    private let cityImageView = UIImageView()
    private let cityLabel = UILabel()
    
    // MARK: - Public Properties
    
    var cityImageURLString: String? {
        didSet {
            guard let urlString = cityImageURLString else { return }
            
            cityImageView.sd_setImage(with: URL(string: urlString))
        }
    }
    
    var cityName: String? {
        didSet {
            cityLabel.text = cityName
        }
    }
    
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
        cityImageView.contentMode = .scaleAspectFit
        
        addSubview(cityImageView)
        cityImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cityImageView.topAnchor.constraint(equalTo: topAnchor),
            cityImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cityImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.xs),
            cityLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.xs),
        ])
        
        cityLabel.font = .boldSystemFont(ofSize: 20)
        cityLabel.textColor = .white
    }
    
}

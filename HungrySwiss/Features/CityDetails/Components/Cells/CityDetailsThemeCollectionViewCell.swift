//
//  CityDetailsThemeCollectionViewCell.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 21/08/2023.
//

import UIKit
import SDWebImage

final class CityDetailsThemeCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifer = "CityDetailsThemeCollectionViewCell"
    
    // MARK: - UI Properties
    
    private let themeImageView = UIImageView()
    private let themeLabel = UILabel()
    
    // MARK: - Public Properties
    
    var themeImageURLString: String? {
        didSet {
            guard let urlString = themeImageURLString else { return }
            
            themeImageView.sd_setImage(with: URL(string: urlString))
        }
    }
    
    var themeTitle: String? {
        didSet {
            themeLabel.text = themeTitle
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
        themeImageView.contentMode = .scaleAspectFit
        
        addSubview(themeImageView)
        themeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            themeImageView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            themeImageView.topAnchor.constraint(equalTo: topAnchor),
            themeImageView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
        ])
        
        addSubview(themeLabel)
        themeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            themeLabel.topAnchor.constraint(equalTo: themeImageView.bottomAnchor, constant: Spacing.xs),
            themeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            themeLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            themeLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
        ])
        
        themeLabel.font = .boldSystemFont(ofSize: 20)
        themeLabel.textColor = .white
    }
    
}

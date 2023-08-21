//
//  CityDetailsRestaurantCollectionViewCell.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 21/08/2023.
//

import UIKit
import SDWebImage

final class CityDetailsRestaurantCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifer = "CityDetailsRestaurantCollectionViewCell"
    
    // MARK: - UI Properties
    
    private let coverImageView = UIImageView()
    private let restaurantIconImageView = UIImageView()
    private let restaurantLabel = UILabel()
    private let restaurantSubtitleLabel = UILabel()
    private let availabilityLabel = UILabel()
    
    // MARK: - Public Properties
    
    var coverImageURLString: String? {
        didSet {
            guard let urlString = coverImageURLString else { return }
            
            coverImageView.sd_setImage(with: URL(string: urlString))
        }
    }
    
    var restaurantIconURLString: String? {
        didSet {
            guard let urlString = restaurantIconURLString else { return }
            
            restaurantIconImageView.sd_setImage(with: URL(string: urlString))
        }
    }
    
    var restaurantTitle: String? {
        didSet {
            restaurantLabel.text = restaurantTitle
        }
    }
    
    var restaurantSubtitle: String? {
        didSet {
            restaurantSubtitleLabel.text = restaurantSubtitle
        }
    }
    
    var isRestaurantOpen: Bool = true {
        didSet {
            updateAvailabilityLabel()
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
        coverImageView.contentMode = .scaleAspectFill
        
        addSubview(coverImageView)
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImageView.topAnchor.constraint(equalTo: topAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        let restaurantTitleStackView = UIStackView(arrangedSubviews: [
            restaurantLabel,
            restaurantSubtitleLabel,
        ])
        restaurantTitleStackView.axis = .vertical
        
        restaurantSubtitleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        let bottomStackView = UIStackView(arrangedSubviews: [
            restaurantTitleStackView,
            availabilityLabel
        ])
        
        bottomStackView.axis = .horizontal
        
        availabilityLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        addSubview(bottomStackView)
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: Spacing.s),
            bottomStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        restaurantLabel.font = .systemFont(ofSize: 12)
        restaurantLabel.textColor = .white
        
        restaurantLabel.font = .systemFont(ofSize: 11)
        restaurantLabel.textColor = .white
    }
    
    private func updateAvailabilityLabel() {
        availabilityLabel.text = isRestaurantOpen ? "Opened" : "Closed"
        availabilityLabel.textColor = isRestaurantOpen ? .green : .red1
    }
    
}


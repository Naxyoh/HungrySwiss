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
        coverImageView.contentMode = .scaleAspectFit
        
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
        restaurantTitleStackView.distribution = .fillEqually
        restaurantTitleStackView.spacing = 4
        
        restaurantSubtitleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        let availabilityLabelContainer = UIView()
        availabilityLabelContainer.addSubview(availabilityLabel)
        availabilityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            availabilityLabel.leadingAnchor.constraint(equalTo: availabilityLabelContainer.leadingAnchor),
            availabilityLabel.trailingAnchor.constraint(equalTo: availabilityLabelContainer.trailingAnchor),
            availabilityLabel.centerYAnchor.constraint(equalTo: availabilityLabelContainer.centerYAnchor)
        ])
        
        let bottomStackView = UIStackView(arrangedSubviews: [
            restaurantTitleStackView,
            availabilityLabelContainer
        ])
        
        bottomStackView.axis = .horizontal
        
        availabilityLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        availabilityLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        addSubview(bottomStackView)
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: Spacing.s),
            bottomStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.xs),
            bottomStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.xs),
            bottomStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        restaurantLabel.font = .systemFont(ofSize: 14)
        restaurantSubtitleLabel.font = .systemFont(ofSize: 12)
    }
    
    private func updateAvailabilityLabel() {
        availabilityLabel.text = isRestaurantOpen ? "Opened" : "Closed"
        availabilityLabel.textColor = isRestaurantOpen ? .green1 : .red1
    }
    
}


//
//  CityListAddressPickerCollectionViewCell.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 20/08/2023.
//

import UIKit

final class CityListAddressPickerCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifer = "CityListAddressPickerCollectionViewCell"
    
    // MARK: - Public Properties
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    
    // MARK: - UI Properties
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
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
        backgroundColor = .red1
        
        let pinIconView = UIImageView(image: UIImage(named: "map"))
        pinIconView.contentMode = .scaleAspectFit
        pinIconView.tintColor = .white
        pinIconView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        addSubview(pinIconView)
        pinIconView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pinIconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.xs),
            pinIconView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel,
        ])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: pinIconView.trailingAnchor, constant: Spacing.xs),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.xs),
        ])
        
        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.textColor = .white
        
        subtitleLabel.font = .systemFont(ofSize: 18)
        subtitleLabel.textColor = .white
    }
    
}

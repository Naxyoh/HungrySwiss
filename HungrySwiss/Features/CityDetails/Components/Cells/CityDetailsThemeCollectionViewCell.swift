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
    
    let hightlightView = UIView()
    
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
    
    var isActive = false {
        didSet {
            themeLabel.textColor = isActive ? .red1 : .gray1
            hightlightView.isHidden = isActive == false
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
        themeImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        addSubview(themeImageView)
        themeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            themeImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            themeImageView.topAnchor.constraint(equalTo: topAnchor),
            themeImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        addSubview(themeLabel)
        themeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            themeLabel.topAnchor.constraint(equalTo: themeImageView.bottomAnchor, constant: Spacing.s),
            themeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            themeLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            themeLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            themeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        themeLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        themeLabel.font = .systemFont(ofSize: 14)
        themeLabel.textColor = .gray1
        
        addSubview(hightlightView)
        hightlightView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hightlightView.centerXAnchor.constraint(equalTo: themeImageView.centerXAnchor),
            hightlightView.centerYAnchor.constraint(equalTo: themeImageView.centerYAnchor),
            hightlightView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            hightlightView.heightAnchor.constraint(equalTo: hightlightView.widthAnchor),
        ])
        
        hightlightView.clipsToBounds = true
        sendSubviewToBack(hightlightView)
        
        hightlightView.backgroundColor = .red1
        hightlightView.isHidden = true
    }
    
}

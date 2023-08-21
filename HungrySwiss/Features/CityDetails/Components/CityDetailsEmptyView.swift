//
//  CityDetailsEmptyView.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 21/08/2023.
//

import UIKit

final class CityDetailsEmptyView: UIView {
    
    // MARK: - UI Properties
    
    private let noResultLabel = UILabel()
    
    // MARK: - Public Properties
    
    var cityName: String? {
        didSet {
            noResultLabel.text = "No result for \"\(cityName ?? "this city")\""
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Configuration
    
    private func configureView() {
        noResultLabel.textAlignment = .center
        noResultLabel.font = .systemFont(ofSize: 32)
        
        addSubview(noResultLabel)
        noResultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            noResultLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            noResultLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            noResultLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: Spacing.s),
            noResultLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -Spacing.s),
        ])
    }
    
}

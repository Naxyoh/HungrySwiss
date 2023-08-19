//
//  CityListViewController.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 17/08/2023.
//

import UIKit

final class CityListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        configureView()
        
        view.backgroundColor = .systemPink
    }
    
    // MARK: - View Configuration
    
    private func configureView() {
        let headerView = UIView()
        headerView.backgroundColor = .gray2
        
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        
        let titleLabel = UILabel()
        titleLabel.text = "Dein Deal\nRestaurant"
        titleLabel.textColor = .red1
        titleLabel.numberOfLines = 0
        titleLabel.font = .boldSystemFont(ofSize: 48)
        
        headerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: Spacing.xs),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
        ])
        
        let cartImageView = UIImageView(image: UIImage(named: "cart"))
        cartImageView.tintColor = .gray1
        
        headerView.addSubview(cartImageView)
        cartImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cartImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: Spacing.xs),
            cartImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cartImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -Spacing.xs),
            cartImageView.heightAnchor.constraint(equalToConstant: 32),
            cartImageView.widthAnchor.constraint(equalToConstant: 22),
        ])
    }
    
}

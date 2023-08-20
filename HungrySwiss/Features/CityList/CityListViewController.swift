//
//  CityListViewController.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 17/08/2023.
//

import UIKit

final class CityListViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private let headerView = UIView()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateCollectionViewLayout())
    private let collectionViewDataSource = CityListCollectionviewDataSource()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        configureView()
        
        view.backgroundColor = .systemPink
    }
    
    // MARK: - View Configuration
    
    private func configureView() {
        configureHeader()
        configureCollectionView()
    }
    
    private func configureHeader() {
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
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -Spacing.s),
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
    
    private func configureCollectionView() {
        collectionView.register(CityListAddressPickerCollectionViewCell.self, forCellWithReuseIdentifier: CityListAddressPickerCollectionViewCell.reuseIdentifer)
        collectionView.dataSource = collectionViewDataSource
        
        collectionViewDataSource.sections = [
            .init(items: [.addressPicker]),
        ]
        
        collectionView.reloadData()
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func generateCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            return self.generateAddressPickerLayout()
            
//            let sectionLayoutKind = CityListViewModel.Section.allCases[sectionIndex]
//            switch sectionLayoutKind {
//            case .addressPicker: return generateAddressPickerLayout()
//            case .nearbyCities: return self.generateSharedlbumsLayout()
//            case .ads: return self.generateMyAlbumsLayout(isWide: isWideView)
//            }
        }
    }
    
    private func generateAddressPickerLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(1/4)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
}

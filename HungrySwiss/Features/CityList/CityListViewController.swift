//
//  CityListViewController.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 17/08/2023.
//

import UIKit
import Combine

final class CityListViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private let headerView = UIView()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateCollectionViewLayout())
    private let collectionViewDataSource = CityListCollectionviewDataSource()
    
    // MARK: - Private Properties
    
    private let viewModel: CityListViewModel
    
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Initialization Methods
    
    init(viewModel: CityListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        configureView()
        bindViewModel()
        
        viewModel.fetchCities()
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
        collectionView.register(CityListCityCollectionViewCell.self, forCellWithReuseIdentifier: CityListCityCollectionViewCell.reuseIdentifer)
        collectionView.dataSource = collectionViewDataSource
        
        collectionViewDataSource.sections = [
            .init(items: [.addressPicker], sectionType: .addressPicker),
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
            
            let sectionLayoutKind = CityListViewModel.SectionType.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .addressPicker: return self.generateAddressPickerLayout()
            case .nearbyCities: return self.generateCitiesLayout()
            case .ads: fatalError()
            }
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
            heightDimension: .fractionalWidth(1/4)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func generateCitiesLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(2/3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.475),
            heightDimension: .fractionalWidth(1/3)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    // MARK: - Private Methods
    
    private func bindViewModel() {
        viewModel.$sections
            .sink { [weak self] sections in
                self?.collectionViewDataSource.sections = sections
                self?.collectionView.reloadData()
            }
            .store(in: &subscriptions)
    }
    
}

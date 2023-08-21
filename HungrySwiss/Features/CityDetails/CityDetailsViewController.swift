//
//  CityDetailsViewController.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 21/08/2023.
//

import UIKit
import Combine

final class CityDetailsViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CityDetailsCollectionViewLayout())
    
    // MARK: Private Properties
    
    private let viewModel: CityDetailsViewModel
    
    private let collectionViewDataSource = CityDetailsCollectionViewDataSource()
    private let collectionViewDelegate = CityDetailsCollectionViewDelegate()
    
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Initialization Methods
    
    init(viewModel: CityDetailsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        bindViewModel()
        
        viewModel.fetchRestaurants()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - View Configuration
    
    private func configureView() {
        configureNavigationBar()
        configureCollectionView()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = viewModel.cityName
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "cart"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .gray1
    }
    
    private func configureCollectionView() {
        collectionView.register(CityListAddressPickerCollectionViewCell.self, forCellWithReuseIdentifier: CityListAddressPickerCollectionViewCell.reuseIdentifer)
        collectionView.register(CityDetailsThemeCollectionViewCell.self, forCellWithReuseIdentifier: CityDetailsThemeCollectionViewCell.reuseIdentifer)
        collectionView.register(CityDetailsRestaurantCollectionViewCell.self, forCellWithReuseIdentifier: CityDetailsRestaurantCollectionViewCell.reuseIdentifer)
        
        collectionView.dataSource = collectionViewDataSource
        
        collectionView.delegate = collectionViewDelegate
        collectionViewDelegate.didSelectFilter = { [weak self] filter in
            self?.viewModel.filterRestaurants(by: filter)
        }
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
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

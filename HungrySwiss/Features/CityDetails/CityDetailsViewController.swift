//
//  CityDetailsViewController.swift
//  HungrySwiss
//
//  Created by Yoan Smit on 21/08/2023.
//

import UIKit

final class CityDetailsViewController: UIViewController {
    
    // MARK: Private Properties
    
    private let viewModel: CityDetailsViewModel
    
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
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        navigationItem.title = viewModel.cityName
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "cart"), style: .plain, target: nil, action: nil)
    }
    
}

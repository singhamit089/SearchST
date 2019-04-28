//
//  HomeViewController.swift
//  SearchST
//
//  Created by Amit  Singh on 28/04/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private var tableView: UITableView!
    private var searchController: UISearchController!
    private let viewModel = SearchItemViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bind()
    }
    
    func bind() {
        
    }
    
    func configureTableView() {
        
        title = "Search"
        
        tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        view = tableView
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        
        // Do any additional setup after loading the view.
        searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
        
        tableView.tableHeaderView = searchController.searchBar
        
        definesPresentationContext = true
        
        tableView.register(
            UINib(nibName: "ItemTableViewCell", bundle: Bundle.main),
            forCellReuseIdentifier: ItemTableViewCell.identifier
        )
        tableView.register(
            UINib(nibName: "LoadMoreTableViewCell", bundle: Bundle.main),
            forCellReuseIdentifier: LoadMoreTableViewCell.identifier
        )
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell:ItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier) as? ItemTableViewCell else {
            fatalError("Table view cell specified could not be found.")
        }
        
        cell.itemTitleLabel.text = "Harry Potter"
        cell.authorsLabel.text = "By Amit Singh, Vishnu, Gopal"
        cell.narratorsLabel.text = "With Subhash, Narendra Yadav, Sameer"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
}

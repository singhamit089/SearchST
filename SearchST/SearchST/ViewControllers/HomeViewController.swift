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
import RxDataSources

class HomeViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private var tableView: UITableView!
    private var searchController: UISearchController!
    private let viewModel = SearchItemViewModel()
    private var tableHeaderView:TableHeaderTableViewCell!
    private var tableFooterView:LoadMoreTableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        bind()
    }
    
    func bind() {
        
        searchController.searchBar.rx.text.asDriver(onErrorJustReturn: "")
            .map { [weak self] text in
                guard let self = self else {
                    return
                }
                self.updateTableHeaderView(with: text ?? "")
                self.viewModel.inputs.searchKeyword.onNext(text)
            }.drive()
            .disposed(by: disposeBag)
        
        tableView.rx.reachedBottom
            .bind(to: viewModel.inputs.loadNextPageTrigger)
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .map { (at: $0, animated: true) }
            .subscribe(onNext: tableView.deselectRow)
            .disposed(by: disposeBag)
        
        viewModel.isLoading
            .drive()
            // .drive(isLoading(for: self.view))
            .disposed(by: disposeBag)
        
        tableView.rx.contentOffset
            .subscribe { _ in
                if self.searchController.searchBar.isFirstResponder {
                    _ = self.searchController.searchBar.resignFirstResponder()
                }
            }
            .disposed(by: disposeBag)

        
        viewModel.outputs.selectedViewModel.drive(onNext: { repoViewModel in
            // Navigate to Item Detail VC
        }).disposed(by: disposeBag)
    }
    
    func setUpUI() {
        configureTableView()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.text = "Harry"
        self.navigationItem.titleView = self.searchController.searchBar;
    }
    
    func configureTableView() {
        
        title = "Search"
        
        tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        view = tableView
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        
        definesPresentationContext = true
        
        tableView.register(
            UINib(nibName: ItemTableViewCell.identifier, bundle: Bundle.main),
            forCellReuseIdentifier: ItemTableViewCell.identifier
        )
        tableView.register(
            UINib(nibName: LoadMoreTableViewCell.identifier, bundle: Bundle.main),
            forCellReuseIdentifier: LoadMoreTableViewCell.identifier
        )
        tableView.register(
            UINib(nibName: TableHeaderTableViewCell.identifier, bundle: Bundle.main),
            forCellReuseIdentifier: TableHeaderTableViewCell.identifier
        )
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableFooterView = tableView.dequeueReusableCell(withIdentifier: LoadMoreTableViewCell.identifier) as? LoadMoreTableViewCell
        tableView.tableFooterView = tableFooterView
        
        tableHeaderView = tableView.dequeueReusableCell(withIdentifier: TableHeaderTableViewCell.identifier) as? TableHeaderTableViewCell
        tableView.tableHeaderView = tableHeaderView
    }
    
    func updateTableHeaderView(with title:String) {
        tableHeaderView.titleLabel.text = "Query : \(title)"
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateTableHeaderView(with: "Row Tapped == \(indexPath.row+1)")
    }
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
        return 100
    }
}

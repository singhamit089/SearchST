//
//  HomeViewController.swift
//  SearchST
//
//  Created by Amit  Singh on 28/04/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {

    var viewModel:HomeViewModel!
    private let disposeBag = DisposeBag()
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel(frame: view.frame)
        label.text = "Hello Search"
        label.center = view.center
        
        view.addSubview(label)
        view.bringSubviewToFront(label)
        view.backgroundColor = .white
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

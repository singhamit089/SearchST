//
//  ItemDetailViewController.swift
//  SearchST
//
//  Created by Amit  Singh on 29/04/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class ItemDetailViewController: UIViewController, LoadableFromNib {

    var viewModel: ItemDetailViewModel?
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var labelOne: UILabel!
    
    @IBOutlet weak var labelTwo: UILabel!
    
    @IBOutlet weak var labelThree: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = viewModel?.item.title ?? ""
        self.descriptionLabel.text = viewModel?.item.description ?? ""
        
        self.labelOne.text = "Original Title : \(viewModel?.item.originalTitle ?? "")"
        self.labelTwo.text = "Type : \(viewModel?.item.type ?? "")"
        self.labelThree.text = "Series Info : \(viewModel?.item.seriesInfo ?? "")"
        
        guard let imageURL = URL(string: viewModel?.item.cover?.url ?? "") else {
            return
        }
        
        imageView.sd_setImage(with: imageURL, completed: { (image: UIImage?, error: Error?, cacheType: SDImageCacheType, imageURL: URL?) in
            self.activityIndicator.removeFromSuperview()
        })
    }
}

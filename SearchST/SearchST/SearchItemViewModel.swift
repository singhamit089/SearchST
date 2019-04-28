//
//  SearchItemViewModel.swift
//  SearchST
//
//  Created by Amit  Singh on 28/04/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

public protocol SearchItemViewModelInputs {
    var searchKeyword: PublishSubject<String?> { get }
    var loadNextPageTrigger: PublishSubject<Void> { get }
    func tapped(item: Item)
}

public protocol SearchItemViewModelOutputs {
    var isLoading: Driver<Bool> { get }
    var elements: BehaviorRelay<[Item]> { get }
    var selectedViewModel: Driver<ItemDetailViewModel> { get }
}

public protocol SearchItemViewModelType {
    var inputs: SearchItemViewModelInputs { get }
    var outputs: SearchItemViewModelOutputs { get }
}

public class SearchItemViewModel: SearchItemViewModelType, SearchItemViewModelInputs, SearchItemViewModelOutputs {
    
    private let disposeBag = DisposeBag()
    private let error = PublishSubject<Error>()
    private var pageIndex: Int = 0
    private var query: String = "harry"
    
    init() {
        selectedViewModel = Driver.empty()
        searchKeyword = PublishSubject<String?>()
        loadNextPageTrigger = PublishSubject<Void>()
        elements = BehaviorRelay<[Item]>(value: [])
        let isLoading = ActivityIndicator()
        self.isLoading = isLoading.asDriver()
        
        let keywordRequest = searchKeyword.asDriver(onErrorJustReturn: "")
            .throttle(0.3)
            .distinctUntilChanged({ $0 == $1 })
            .flatMap { [weak self] query -> Driver<[Item]> in
                
                guard let self = self else {
                    return Driver.empty()
                }
                
                self.pageIndex = 0
                self.elements.accept([])
                self.query = query!
                return API.sharedAPI.searchItem(query!, page: self.pageIndex).trackActivity(isLoading).asDriver(onErrorDriveWith: Driver.empty())
        }
        
        let nextPageRequest = isLoading.asObservable().sample(loadNextPageTrigger).flatMap { [weak self] _isLoading -> Driver<[Item]> in
            
            guard let self = self else {
                return Driver.empty()
            }
            if _isLoading.hashValue == 0 && self.query != "" {
                self.pageIndex = self.pageIndex + 10
                return API.sharedAPI.searchItem(self.query, page: self.pageIndex)
                        .trackActivity(isLoading)
                        .asDriver(onErrorJustReturn: [])
            }
            
            return Driver.empty()
        }
        
        let request = Observable.of(keywordRequest.asObservable(), nextPageRequest)
            .merge()
            .share(replay: 1)
        
        let response = request.flatMap { _ -> Observable<[Item]> in
            request
                .do(onError: { _error in
                    self.error.onNext(_error)
                }).catchError({ _ -> Observable<[Item]> in
                    Observable.empty()
                })
            }.share(replay: 1)
        
        Observable
            .combineLatest(request, response, elements.asObservable()) { _, response, elements in
                return self.pageIndex == 1 ? response : elements + response
            }
            .sample(response)
            .bind(to: elements)
            .disposed(by: disposeBag)
        
        selectedViewModel = item.asDriver().filter({ item -> Bool in
            guard let id = item?.id else {
                return false
            }
            return true
        }).flatMapLatest { item -> Driver<ItemDetailViewModel> in
            return Driver.just(ItemDetailViewModel())
        }
    }
    
    let item = BehaviorRelay<Item?>(value: nil)
    public func tapped(item: Item) {
        self.item.accept(item)
    }
    
    public var inputs: SearchItemViewModelInputs { return self }
    public var outputs: SearchItemViewModelOutputs { return self }
    public var searchKeyword: PublishSubject<String?>
    public var loadNextPageTrigger: PublishSubject<Void>
    public var isLoading: Driver<Bool>
    public var elements: BehaviorRelay<[Item]>
    public var selectedViewModel: Driver<ItemDetailViewModel>
}

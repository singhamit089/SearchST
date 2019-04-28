//
//  SearchItemViewModelSpec.swift
//  SearchSTTests
//
//  Created by Amit  Singh on 28/04/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

@testable import SearchST
import Moya
import Nimble
import Quick
import RxCocoa
import RxSwift
import RxTest

class SearchItemViewModelSpec: QuickSpec {
    
    override func spec() {
        var sut : SearchItemViewModel!
        var scheduler : TestScheduler!
        var disposeBag: DisposeBag!
        
        beforeEach {
            
            let bundle = Bundle(for: type(of: self))
            guard let path = bundle.path(forResource: "SearchResponse", ofType: "json") else {
                fatalError("Enable to find json file in the given path")
            }
            stubJsonPath =  path
            
            StorytelProvider = MoyaProvider()
            
            scheduler = TestScheduler(initialClock: 0)
            SharingScheduler.mock(scheduler: scheduler, action: {
                sut = SearchItemViewModel()
            })
            
            disposeBag = DisposeBag()
        }
        
        afterEach {
            scheduler = nil
            sut = nil
            disposeBag = nil
        }
        
        xit("returns ten items when queried") {
            
            let observer = scheduler.createObserver([Item].self)
            
            scheduler.scheduleAt(100, action: {
                sut.outputs.elements.asObservable()
                    .subscribe(observer)
                    .disposed(by: disposeBag)
            })
            
            scheduler.scheduleAt(200) {
                sut.inputs.searchKeyword.onNext("harry")
            }
            
            scheduler.start()
            
            let results = observer.events.first.map { event in
                event.value.element!.count
            }
            
            expect(results) == 10
        }
    }
}

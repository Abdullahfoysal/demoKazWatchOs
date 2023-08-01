//
//  SubscriptionService.swift
//  kazWatchOs
//
//  Created by KAZ MAC 5 on 1/8/23.
//

import RxSwift

class SubscriptionService {
    
    
    
    init() {
        
       
        let disposeBag = DisposeBag()

        Observable.of("One", "Two", "Three", "Four")

        .subscribe({
          print($0)
        })

        .disposed(by: disposeBag)
    }
    
    
   
    
    
    
    
}

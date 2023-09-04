//
//  SubscriptionService.swift
//  kazWatchOs
//
//  Created by KAZ MAC 5 on 2/8/23.
//


import RxSwift
import RxCocoa


struct SubscriptionViewModel {
    
    var publishSubjectSubscriptionItems = PublishSubject<[String]>()
    var behaviourSubjectSubscriptionItems = BehaviorSubject<[String]>(value: ["Initial subscription item"])
    var replaySubjectSubscriptionItems = ReplaySubject<[String]>.create(bufferSize: 2)
    
    func startTimerOfSubscription(){
        var count = 0
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            publishSubjectSubscriptionItems.onNext(["publishSubjectSubscriptionItems \(count)"])
            behaviourSubjectSubscriptionItems.onNext(["behaviourSubjectSubscriptionItems \(count)"])
            replaySubjectSubscriptionItems.onNext(["replaySubjectSubscriptionItems \(count)"])
            count  = count + 1
        }
    }
}

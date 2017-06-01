//
//  TimerService.swift
//  crash-reporting-demo
//
//  Created by Jakub Olejník on 01/06/2017.
//
//

import ReactiveSwift
import enum Result.NoError

final class TimerService {
    
    func after(seconds: Int) -> SignalProducer<Void, NoError> {
        return timer(interval: .seconds(seconds), on: QueueScheduler.main)
            .take(first: 1)
            .map { _ in }
    }
    
}

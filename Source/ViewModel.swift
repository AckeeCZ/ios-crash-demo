//
//  ViewModel.swift
//  crash-reporting-demo
//
//  Created by Jakub Olejník on 01/06/2017.
//
//

import ReactiveSwift
import enum Result.NoError

public final class ViewModel {
    private let timerService = TimerService()
    
    public lazy var action: Action<Void, Void, NoError> = Action { [unowned self] in
        self.timerService.after(seconds: 1)
    }

    public lazy var crash: Action<Void, Void, NoError> = Action { [unowned self] in
        self.timerService.after(seconds: 1).on(completed: {
            fatalError("Test crash in VM")
        })
    }
    
    // MARK: Initializers
    
    public init() { }
}

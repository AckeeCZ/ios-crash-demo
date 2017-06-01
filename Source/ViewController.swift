//
//  ViewController.swift
//  crash-reporting-demo
//
//  Created by Jakub Olejník on 01/06/2017.
//
//

import UIKit
import SnapKit
import Framework
import Crashlytics
import ReactiveCocoa
import ReactiveSwift

public final class ViewController: UIViewController {

    private weak var crashVCButton: UIButton!
    private weak var crashVMButton: UIButton!
    private weak var showButton: UIButton!
    
    private let viewModel = ViewModel()
    
    // MARK: View life cycle
    
    public override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        let crashVCButton = UIButton(type: .system)
        crashVCButton.setTitle("Crash after 1 second in controller", for: .normal)
        self.crashVCButton = crashVCButton
        
        let crashVMButton = UIButton(type: .system)
        crashVMButton.setTitle("Crash after 1 second in viewModel", for: .normal)
        self.crashVMButton = crashVMButton
        
        let showButton = UIButton(type: .system)
        showButton.setTitle("Show next controller", for: .normal)
        self.showButton = showButton
        
        let vStack = UIStackView(arrangedSubviews: [showButton, crashVCButton, crashVMButton])
        vStack.axis = .vertical
        vStack.spacing = 20
        view.addSubview(vStack)
        vStack.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
    }
    
    // MARK: Private helpers
    
    private func setupBindings() {
        viewModel.action <~ crashVCButton.reactive.controlEvents(.primaryActionTriggered).map { _ in }
        viewModel.crash <~ crashVMButton.reactive.controlEvents(.primaryActionTriggered).map { _ in }
        
        viewModel.action.completed.observeValues {
            Crashlytics.sharedInstance().crash()
        }
    }
}


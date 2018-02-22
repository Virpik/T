//
//  SimulatioAppFlow.swift
//  TDemo
//
//  Created by Virpik on 21/02/2018.
//  Copyright © 2018 Virpik. All rights reserved.
//

import Foundation
import UIKit
import T

struct PresentSettingsFlow: TFlow {
    typealias Context = Settings
    
    lazy var displayWorker: TFlowItemViewControllerWorker<SimulatioAppViewController, Context> = {
        var dWorker = TFlowItemViewControllerWorker<SimulatioAppViewController, Context>()
        
        dWorker.worker? = self._showWorker(context:viewController:handler:)
        
        return dWorker
    }()
    
    init() {
        
    }
    
    private func _showWorker(context: Context, viewController: SimulatioAppViewController, handler: (Context) -> ()) {
        viewController.show(setting: context)
        handler(context)
    }
}

struct SimulatioAppFlow: TFlow {
    typealias Context = Settings
    
    private(set) var viewController: SimulatioAppViewController
    private var context: Context
    
    private var _presentFlow: PresentSettingsFlow = PresentSettingsFlow()
    
    init() {
        self.viewController = SimulatioAppViewController()
        self.context = Context()
        
        self._presentFlow.displayWorker.worker?(self.context, self.viewController, {_ in})
    }

    func build(baseContext: SimulatioAppFlow.Context?) {
        
    }
}


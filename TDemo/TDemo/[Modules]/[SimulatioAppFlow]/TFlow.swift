//
//  TFlow.swift
//  TDemo
//
//  Created by Virpik on 21/02/2018.
//  Copyright © 2018 Virpik. All rights reserved.
//

import Foundation
import UIKit

protocol TFlow {
    associatedtype Context
    
    func build (baseContext: Context?)
}

extension TFlow {
    func build (baseContext: Context? = nil) {
        
    }
}

struct TFlowItemWorker <FlowContext> {
    var worker: ((FlowContext, (FlowContext) -> ()) -> ())?
}

struct TFlowItemViewWorker <View: UIView, FlowContext> {
    var worker: ((FlowContext, View, (FlowContext) -> ()) -> ())?
}

struct TFlowItemViewControllerWorker <ViewController: UIViewController, FlowContext> {
    var worker: ((FlowContext, ViewController, (FlowContext) -> ()) -> ())?
}

//
//  FlowController.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 1/17/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import UIKit

class FlowController: NSObject {

    var flowConfigure : FlowConfigure
    var rootViewController : UIViewController?
    var state : State?
    
    required init(flowConfigure : FlowConfigure) {
        self.flowConfigure = flowConfigure
    }
    
    public func popToFlowRootController(animated : Bool = true){
        self.flowConfigure.popToFlowRootController(animated: animated)
    }
    
    func start(){
        let navigationController = self.flowConfigure.navigationController
        
        let viewController = self.state!.nextStep(flowController: self)
        navigationController!.pushViewController(viewController, animated: true)
    }
}
 

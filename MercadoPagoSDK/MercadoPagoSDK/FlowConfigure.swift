//
//  FlowConfigure.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 1/17/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import UIKit

class FlowConfigure: NSObject {

    var navigationController : UINavigationController?
    var rootViewController : UIViewController?
    var parent : FlowController?
    
    init(navigationController : UINavigationController? = nil, parent : FlowController? = nil){
        self.navigationController = navigationController
        self.rootViewController = navigationController!.viewControllers.last
        self.parent = parent
    }
    
    public func popToFlowRootController(animated : Bool){
        self.navigationController?.popToViewController(self.rootViewController!, animated: animated)
    }
    
}

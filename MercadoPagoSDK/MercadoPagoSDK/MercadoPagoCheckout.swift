//
//  MercadoPagoCheckout.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 1/20/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import UIKit

open class MercadoPagoCheckout: NSObject {

    var navigationController : UINavigationController?
    var checkoutPreference : CheckoutPreference
    
    init(navigationController : UINavigationController, checkoutPrefence : CheckoutPreference) {
        self.navigationController = navigationController
        self.checkoutPreference = checkoutPrefence
    }
    
    open func start() {
        let configure = FlowConfigure(navigationController: self.navigationController)
        let checkoutViewModel = CheckoutViewModel(checkoutPreference: self.checkoutPreference)
        // mercadoPagoCheckout? en vez de flow?
        let checkoutFlowController = CheckoutFlowController(flowConfigure: configure, checkoutViewModel: checkoutViewModel)
        checkoutFlowController.start()
    }
}

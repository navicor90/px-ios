//
//  MockCheckoutViewController.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 22/1/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import Foundation
import UIKit

class MockCheckoutViewController: CheckoutViewController {
    

    var startPaymentVaultInvoked = false
    
    init(preferenceId: String, callback: (payment : Payment)-> Void) {
        super.init(preferenceId: preferenceId, callback: callback)
        self.viewModel = CheckoutViewModel()
        self.animate = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override internal func startPaymentVault(animated : Bool = false){
        self.startPaymentVaultInvoked = true
        super.startPaymentVault()
    }
    
}

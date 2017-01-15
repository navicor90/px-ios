//
//  AddCouponViewModel.swift
//  MercadoPagoSDK
//
//  Created by Demian Tejo on 1/14/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import UIKit

class AddCouponViewModel: NSObject {
    
    var amount : Double!
    var coupon : DiscountCoupon?
  
    
    init(amount : Double) {
        self.amount = amount
    }
    

    func getCoupon(code: String, success: @escaping (Void) -> Void, failure: @escaping ((_ errorMessage: String) -> Void)){
        let disco = DiscountService()

        disco.getDiscount(amount: self.amount, code: code, success: { (coupon) in
            if let coupon = coupon{
                self.coupon = coupon
                success()
            }
        }) { (error) in
            if (error.localizedDescription == "campaign-code-doesnt-match"){
                failure("Código inválido".localized)
            }else {
                failure("Hubo un error".localized)
            }
        }
    }
    

}

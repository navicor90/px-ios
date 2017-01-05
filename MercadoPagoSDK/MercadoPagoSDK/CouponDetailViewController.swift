//
//  CouponDetailViewController.swift
//  MercadoPagoSDK
//
//  Created by Demian Tejo on 12/23/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

open class CouponDetailViewController: MercadoPagoUIViewController {
    
    override open var screenName : String { get { return "DISCOUNT_SUMMARY" } }
    
    var coupon : DiscountCoupon!
    var couponView : DiscountDetailView!
    
    
    init(coupon : DiscountCoupon, callbackCancel : ((Void) -> Void)? = nil) {
        super.init(nibName: "CouponDetailViewController", bundle: MercadoPago.getBundle())
        self.callbackCancel = callbackCancel
        self.coupon = coupon
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = MercadoPagoContext.getPrimaryColor()
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let screenWidth = screenSize.width
        //TODO ARREGALAR BONITO
        let xPos = (screenWidth - 256)/2
        let yPos = (screenHeight - 200)/2
        self.couponView = DiscountDetailView(frame:CGRect(x: xPos, y: yPos, width: 256, height: 200), coupon: self.coupon, amount:self.coupon.amount)
        self.couponView.layer.cornerRadius = 4
        self.couponView.layer.masksToBounds = true
        self.view.addSubview(self.couponView)
    }
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func exit(){
        guard let callbackCancel = self.callbackCancel else {
            self.dismiss(animated: false, completion: nil)
            return
        }
        self.dismiss(animated: false) { 
            callbackCancel()
        }
        
    }
    
}

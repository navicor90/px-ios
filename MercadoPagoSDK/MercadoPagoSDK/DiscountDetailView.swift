//
//  DiscountDetailView.swift
//  MercadoPagoSDK
//
//  Created by Demian Tejo on 12/26/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

class DiscountDetailView: UIView {
    
    @IBOutlet weak var viewTitle: UILabel!
   
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productAmount: UILabel!
    
    @IBOutlet weak var discountTitle: UILabel!
    @IBOutlet weak var discountAmount: UILabel!
    
    @IBOutlet weak var totalTitle: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    
    
    var coupon: DiscountCoupon!
    var amount: Double!
    
    
    init(frame: CGRect, coupon: DiscountCoupon, amount: Double) {
        super.init(frame: frame)
        self.coupon = coupon
        self.amount = amount
        loadViewFromNib ()
        
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
    }
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "DiscountDetailView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        self.productAmount.text = "$" + String(amount)
        self.discountAmount.text = "$" + coupon.amount_off
        self.totalAmount.text = "$" + String(amount - Double(coupon.amount_off)!)
    }

}

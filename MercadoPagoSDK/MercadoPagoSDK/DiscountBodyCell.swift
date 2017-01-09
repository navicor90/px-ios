//
//  DiscountBodyCell.swift
//  MercadoPagoSDK
//
//  Created by Demian Tejo on 1/5/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import UIKit

class DiscountBodyCell: UIView {

   // @IBOutlet weak var viewTitle: UILabel!
    
    @IBOutlet weak var discountTitle: UILabel!
 //   @IBOutlet weak var discountAmount: UILabel!
    
  //  @IBOutlet weak var totalTitle: UILabel!
  //  @IBOutlet weak var totalAmount: UILabel!
    
    
    var coupon: DiscountCoupon?

    
    init(frame: CGRect, coupon: DiscountCoupon?) {
        super.init(frame: frame)
        self.coupon = coupon
        loadViewFromNib ()
        if self.coupon == nil{
            self.discountTitle.text = "No hay descuento"
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
    }
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "DiscountBodyCell", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
      
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }

}

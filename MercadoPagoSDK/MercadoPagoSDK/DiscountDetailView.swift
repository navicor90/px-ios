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
    
    @IBOutlet weak var shiphingTitle: UILabel!
    @IBOutlet weak var shippingAmount: UILabel!
    
    
    @IBOutlet weak var totalTitle: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    }

}

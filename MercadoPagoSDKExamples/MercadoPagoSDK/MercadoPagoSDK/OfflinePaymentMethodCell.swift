//
//  PaymentMethodCell.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 29/1/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

class OfflinePaymentMethodCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!

    @IBOutlet weak var comment: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    internal func fillRowWithPaymentMethod(paymentMethod: PaymentMethod) {
        self.iconImage.image = MercadoPago.getImageFor(paymentMethod)
        self.comment.text = paymentMethod.comment
    }

}

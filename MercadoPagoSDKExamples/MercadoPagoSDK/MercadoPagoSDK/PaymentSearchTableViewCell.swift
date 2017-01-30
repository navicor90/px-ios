//
//  PaymentSearchRowTableViewCell.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 15/1/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

class PaymentSearchRowTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func fillRowWithPayment(paymentSearchItem: PaymentMethodSearchItem) {
        self.paymentTitle.text = paymentSearchItem.description
        self.paymentIcon.image = MercadoPago.getImage(paymentSearchItem.iconName)

    }
}

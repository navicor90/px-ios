//
//  MPPaymentMethodTableViewCell.swift
//  MercadoPagoSDK
//
//  Created by Matias Gualino on 7/1/15.
//  Copyright (c) 2015 com.mercadopago. All rights reserved.
//

import Foundation
import UIKit

public class MPPaymentMethodTableViewCell: UITableViewCell {
	@IBOutlet weak private var paymentMethodTitleLabel: UILabel!
    @IBOutlet weak private var cardTextLabel: UITextField!
    @IBOutlet weak private var cardIcon: UIImageView!

    override public init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
		self.paymentMethodTitleLabel.text = "Medio de pago".localized
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

	private func setEmptyPaymentMethod() {
		self.cardTextLabel.text = "Selecciona un medio de pago...".localized
		self.cardIcon.image = MercadoPago.getImage("empty_tc")
	}

    public func fillWithCard(card: Card?) {
        if card == nil || card!.paymentMethod == nil {
			setEmptyPaymentMethod()
        } else {
            self.cardTextLabel.text = card!.paymentMethod!.name + " " + "terminada en".localized + " " + card!.lastFourDigits!
            self.cardIcon.image = MercadoPago.getImage("icoTc_" + card!.paymentMethod!._id)
        }
    }

    public func fillWithCardTokenAndPaymentMethod(card: CardToken?, paymentMethod: PaymentMethod?) {
        if card == nil || paymentMethod == nil {
			setEmptyPaymentMethod()
        } else {
            let range = Range(start: card!.cardNumber!.characters.endIndex.advancedBy(-4),
                end: card!.cardNumber!.endIndex)
            let lastFourDigits: String = card!.cardNumber!.substringWithRange(range)
            self.cardTextLabel.text = paymentMethod!.name + " " + "terminada en".localized + " " + lastFourDigits
            self.cardIcon.image = MercadoPago.getImage("icoTc_" + paymentMethod!._id)
        }
    }

    public func fillWithPaymentMethod(paymentMethod: PaymentMethod?) {
        if paymentMethod == nil {
			setEmptyPaymentMethod()
        } else {
           self.cardTextLabel.text = paymentMethod!.name
            self.cardIcon.image = MercadoPago.getImage("icoTc_" + paymentMethod!._id)
        }
    }

}

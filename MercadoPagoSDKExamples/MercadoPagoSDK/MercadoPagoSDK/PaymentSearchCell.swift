//
//  PaymentSearchRowTableViewCell.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 15/1/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

class PaymentSearchCell: UITableViewCell {

    @IBOutlet weak var paymentTitle: UILabel!

    @IBOutlet weak var paymentIcon: UIImageView!

    @IBOutlet weak var paymentComment: UILabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func fillRowWithPayment(paymentSearchItem: PaymentMethodSearchItem, iconImage: UIImage, tintColor: Bool) {
        self.paymentTitle.text = paymentSearchItem.description
        if tintColor {
            let tintedImage = iconImage.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            self.paymentIcon.image = tintedImage
            self.paymentIcon.tintColor = UIColor().blueMercadoPago()
        } else {
            self.paymentIcon.image = iconImage
            self.paymentTitle.hidden = true
        }

        if paymentSearchItem.comment != nil {
            self.paymentComment.text = paymentSearchItem.comment
        } else {
            self.paymentComment.hidden = true
        }
    }
}

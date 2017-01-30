//
//  PaymentTitleAndCommentViewCell.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 11/2/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

class PaymentTitleAndCommentViewCell: UITableViewCell {

    @IBOutlet weak var paymentTitle: UILabel!

    @IBOutlet weak var paymentComment: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func fillRowWith(paymentTitle: String, paymentComment: String) {
        self.paymentTitle.text = paymentTitle
        self.paymentComment.text = paymentComment
    }

}

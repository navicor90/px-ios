//
//  PreferenceDescriptionCellTableViewCell.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 4/2/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

class PreferenceDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var preferenceDescription: UILabel!

    @IBOutlet weak var shoppingCartIcon: UIImageView!
    @IBOutlet weak var preferenceAmount: UILabel!

    @IBOutlet weak var shoppingCartIconContainer: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tintedImage = self.shoppingCartIcon.image!.imageWithRenderingMode(.AlwaysTemplate)
        self.shoppingCartIcon.image = tintedImage
        self.shoppingCartIcon.tintColor = UIColor().white()

        self.shoppingCartIconContainer.layer.borderWidth = 1.0
        self.shoppingCartIconContainer.layer.borderColor = UIColor.whiteColor().CGColor

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    internal func fillRowWithPreference(preference: CheckoutPreference) {
        self.preferenceAmount.text = "$" + String(preference.getAmount())
        self.preferenceDescription.text = preference.items![0].title
        if preference.items![0].pictureUrl != nil {
            self.shoppingCartIcon.image = MercadoPago.getImage(preference.items![0].pictureUrl)
        }

    }

}

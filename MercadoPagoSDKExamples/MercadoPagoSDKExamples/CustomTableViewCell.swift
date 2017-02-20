//
//  CustomTableViewCell.swift
//  MercadoPagoSDKExamples
//
//  Created by Eden Torres on 2/6/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import UIKit
import MercadoPagoSDK

open class CustomTableViewCell: UITableViewCell {
    //var imageDelegate: bundle.CellProtocol?
    @IBOutlet open weak var title: UILabel!

    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fillCell(text: String){
        title.text = text
    }

    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

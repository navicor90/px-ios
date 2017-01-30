//
//  SimpleInstructionWithButtonViewCell.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 18/2/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

class SimpleInstructionWithButtonViewCell: UITableViewCell, InstructionsFillmentDelegate {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var referenceLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var referenceValue: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.button.layer.borderWidth = 1.0
        self.button.layer.cornerRadius = 5
        self.button.layer.borderColor = UIColor().blueMercadoPago().CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func fillCell(instruction: Instruction) -> UITableViewCell {
        self.title.text  = instruction.info[0]
        self.referenceLabel.text = instruction.references[0].label.uppercaseString
        self.referenceValue.text = instruction.references[0].getFullReferenceValue()

        return self
    }

}

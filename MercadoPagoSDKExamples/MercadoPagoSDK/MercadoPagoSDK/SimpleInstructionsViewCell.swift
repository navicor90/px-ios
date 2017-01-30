//
//  SimpleInstructionViewCellTableViewCell.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 17/2/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

class SimpleInstructionsViewCell: UITableViewCell, InstructionsFillmentDelegate {

    @IBOutlet weak var infoTitle: UILabel!
    @IBOutlet weak var referenceValue: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func fillCell(instruction: Instruction) -> UITableViewCell {
        self.infoTitle.text = instruction.info[0]
        self.referenceValue.text = instruction.references[0].getFullReferenceValue()
        return self
    }

}

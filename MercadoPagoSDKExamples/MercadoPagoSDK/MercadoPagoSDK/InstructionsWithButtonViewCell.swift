//
//  InstructionsWithButtonViewCell.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 18/2/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

class InstructionsWithButtonViewCell: UITableViewCell, InstructionsFillmentDelegate {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var referenceLabelFirst: UILabel!

    @IBOutlet weak var referenceValueFirst: UILabel!
    @IBOutlet weak var referenceLabelSecond: UILabel!

    @IBOutlet weak var referenceValueSecond: UILabel!
    @IBOutlet weak var referenceLabelThird: UILabel!
    @IBOutlet weak var referenceValueThird: UILabel!

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
        self.referenceLabelFirst.text  = instruction.references[0].label.uppercaseString
        self.referenceValueFirst.text = instruction.references[0].getFullReferenceValue()
        self.referenceLabelSecond.text = instruction.references[1].label.uppercaseString
        self.referenceValueSecond.text = instruction.references[1].getFullReferenceValue()
        self.referenceLabelThird.text = instruction.references[2].label.uppercaseString
        self.referenceValueThird.text = instruction.references[2].getFullReferenceValue()
        return self
    }

}

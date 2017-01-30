//
//  InstructionsTwoLabelsAndButtonViewCell.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 18/2/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

class InstructionsTwoLabelsAndButtonViewCell: UITableViewCell, InstructionsFillmentDelegate {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var infoTitle: UILabel!
    @IBOutlet weak var referenceLabelFirst: UILabel!
    @IBOutlet weak var referenceValueFirst: UILabel!

    @IBOutlet weak var referenceLabelSecond: UILabel!
    @IBOutlet weak var referenceValueSecond: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.button.layer.borderWidth = 1.0
        self.button.layer.cornerRadius = 5
        self.button.layer.borderColor = UIColor().blueMercadoPago().CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func fillCell(instruction: Instruction) -> UITableViewCell {
        self.infoTitle.text = instruction.info[0]
        self.referenceLabelFirst.text = instruction.references[0].label
        self.referenceValueFirst.text = instruction.references[0].getFullReferenceValue()

        if (instruction.references.count > 1) {
            self.referenceLabelSecond.text = instruction.references[1].label
            self.referenceValueSecond.text = instruction.references[1].getFullReferenceValue()
        } else {
            self.referenceLabelSecond.text = ""
            self.referenceValueSecond.text = ""
        }

        return self
    }

}

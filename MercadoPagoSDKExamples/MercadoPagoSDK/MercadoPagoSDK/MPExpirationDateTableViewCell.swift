//
//  MPExpirationDateTableViewCell.swift
//  MercadoPagoSDK
//
//  Created by Matias Gualino on 30/12/14.
//  Copyright (c) 2014 com.mercadopago. All rights reserved.
//

import Foundation
import UIKit

public class MPExpirationDateTableViewCell: ErrorTableViewCell, UITextFieldDelegate {
    @IBOutlet weak private var expirationDateLabel: UILabel!
    @IBOutlet weak public var expirationDateTextField: UITextField!

	public override func focus() {
		if !self.expirationDateTextField.isFirstResponder() {
			self.expirationDateTextField.becomeFirstResponder()
		}
	}

    override public init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
		self.expirationDateLabel.text = "Válida hasta".localized
		self.expirationDateTextField.placeholder = "Mes / Año".localized
        self.expirationDateTextField.delegate = self
        self.expirationDateTextField.keyboardType = UIKeyboardType.NumberPad
    }

    required public  init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func getExpirationMonth() -> Int {
        if String.isNullOrEmpty(self.expirationDateTextField.text) {
            return 0
        }

		if self.expirationDateTextField.text != nil {
			var monthStr: NSString = self.expirationDateTextField.text!.characters.split {$0 == "/"}.map(String.init)[0] as String
			monthStr = monthStr.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
			return monthStr.integerValue
		}
		return 0
    }

    public func getExpirationYear() -> Int {
        if String.isNullOrEmpty(self.expirationDateTextField.text) {
            return 0
        }

		if self.expirationDateTextField.text != nil {
			var yearStr: NSString = self.expirationDateTextField.text!.characters.split {$0 == "/"}.map(String.init)[1] as String
			yearStr = yearStr.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
			return yearStr.integerValue
		}

        return 0
    }

    public func setTextFieldDelegate(delegate: UITextFieldDelegate) {
        self.expirationDateTextField.delegate = delegate
    }

    public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {

        if !Regex("^[0-9]$").test(string) && string != "" {
            return false
        }
		if textField.text != nil {
			var txtAfterUpdate: NSString = textField.text!
			txtAfterUpdate = txtAfterUpdate.stringByReplacingCharactersInRange(range, withString: string)
			var str: String = ""
			if txtAfterUpdate.length <= 7 {
				var date: NSString = txtAfterUpdate.stringByReplacingOccurrencesOfString(" ", withString:"")
				date = date.stringByReplacingOccurrencesOfString("/", withString:"")
				if date.length >= 1 && date.length <= 4 {
					for i in 0...(date.length-1) {
						if i == 2 {
							str = str + " / "
						}
						str = str + String(format: "%C", date.characterAtIndex(i))
					}
				}
				self.expirationDateTextField.text = str
			}
		}

		return false
    }
}

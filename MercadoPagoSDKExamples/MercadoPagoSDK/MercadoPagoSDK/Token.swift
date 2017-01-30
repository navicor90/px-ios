//
//  Token.swift
//  MercadoPagoSDK
//
//  Created by Matias Gualino on 28/12/14.
//  Copyright (c) 2014 com.mercadopago. All rights reserved.
//

import Foundation

public class Token: NSObject {
	public var _id: String!
	public var publicKey: String!
	public var cardId: String!
	public var luhnValidation: String!
	public var status: String!
	public var usedDate: String!
	public var cardNumberLength: Int = 0
	public var creationDate: NSDate!
	public var truncCardNumber: String!
	public var securityCodeLength: Int = 0
	public var expirationMonth: Int = 0
	public var expirationYear: Int = 0
	public var lastModifiedDate: NSDate!
	public var dueDate: NSDate!

	public init (_id: String, publicKey: String, cardId: String!, luhnValidation: String!, status: String!,
		usedDate: String!, cardNumberLength: Int, creationDate: NSDate!, truncCardNumber: String!,
		securityCodeLength: Int, expirationMonth: Int, expirationYear: Int, lastModifiedDate: NSDate!,
		dueDate: NSDate?) {
			super.init()
			self._id = _id
			self.publicKey = publicKey
			self.cardId = cardId
			self.luhnValidation = luhnValidation
			self.status = status
			self.usedDate = usedDate
			self.cardNumberLength = cardNumberLength
			self.creationDate = creationDate
			self.truncCardNumber = truncCardNumber
			self.securityCodeLength = securityCodeLength
			self.expirationMonth = expirationMonth
			self.expirationYear = expirationYear
			self.lastModifiedDate = lastModifiedDate
			self.dueDate = dueDate
	}

	public class func fromJSON(json: NSDictionary) -> Token {
		let id = JSON(json["id"]!).asString!
		let publicKey = JSON(json["public_key"]!).asString!
		let cardId = JSON(json["card_id"]!).asString
		let status = JSON(json["status"]!).asString
		let luhn = json.isKeyValid("luhn_validation") ? JSON(json["luhn_validation"]!).asString : ""
		let usedDate = json.isKeyValid("date_used") ? JSON(json["date_used"]!).asString : ""
		let cardNumberLength = json.isKeyValid("card_number_length") ? JSON(json["card_number_length"]!).asInt! : 0
		let creationDate = json.isKeyValid("date_created") ? Utils.getDateFromString(json["date_created"] as? String) : NSDate()
		let truncCardNumber = json.isKeyValid("last_four_digits") ? JSON(json["last_four_digits"]!).asString : ""
		let securityCodeLength = json.isKeyValid("security_code_length") ? JSON(json["security_code_length"]!).asInt! : 0
		let expMonth = json.isKeyValid("expiration_month") ? JSON(json["expiration_month"]!).asInt! : 0
		let expYear = json.isKeyValid("expiration_year") ? JSON(json["expiration_year"]!).asInt! : 0
		let lastModifiedDate = json.isKeyValid("date_last_updated") ? Utils.getDateFromString(json["date_last_updated"] as? String) : NSDate()
		let dueDate = json.isKeyValid("date_due") ? Utils.getDateFromString(json["date_due"] as? String) : NSDate()

		return Token(_id: id, publicKey: publicKey, cardId: cardId, luhnValidation: luhn, status: status,
			usedDate: usedDate, cardNumberLength: cardNumberLength, creationDate: creationDate, truncCardNumber: truncCardNumber,
			securityCodeLength: securityCodeLength, expirationMonth: expMonth, expirationYear: expYear, lastModifiedDate: lastModifiedDate,
			dueDate: dueDate)
	}
}

extension NSDictionary {
	public func isKeyValid(dictKey: String) -> Bool {
		let dictValue: AnyObject? = self[dictKey]
		return (dictValue == nil || dictValue is NSNull) ? false : true
	}
}

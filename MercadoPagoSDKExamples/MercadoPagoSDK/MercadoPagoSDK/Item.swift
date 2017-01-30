//
//  Item.swift
//  MercadoPagoSDK
//
//  Created by Matias Gualino on 31/12/14.
//  Copyright (c) 2014 com.mercadopago. All rights reserved.
//

import Foundation

public class Item: NSObject {
    public var _id: String!
    public var quantity: Int = 0
    public var unitPrice: Double = 0
    public var title: String!
    public var currencyId: String!
    public var categoryId: String!
    public var pictureUrl: String!

    internal override init() {
        super.init()
    }

    public init(_id: String, title: String, quantity: Int, unitPrice: Double) {
        super.init()
        self._id = _id
        self.title = title
        self.quantity = quantity
        self.unitPrice = unitPrice

    }

    public func toJSONString() -> String {
        let obj: [String:AnyObject] = [
            "id": self._id!,
            "quantity": self.quantity,
            "unit_price": self.unitPrice
        ]
        return JSON(obj).toString()
    }

    public class func fromJSON(json: NSDictionary) -> Item {
        let item = Item()
        if json["id"] != nil && !(json["id"]! is NSNull) {
            item._id = JSON(json["id"]!).asString
        }

        if json["quantity"] != nil && !(json["quantity"]! is NSNull) {
            item.quantity =  JSON(json["quantity"]!).asInt!
        }

        if json["unit_price"] != nil && !(json["unit_price"]! is NSNull) {
            item.unitPrice =  JSON(json["unit_price"]!).asDouble!
        }

        if json["title"] != nil && !(json["title"]! is NSNull) {
            item.title =  JSON(json["title"]!).asString
        }

        if json["currency_id"] != nil && !(json["currency_id"]! is NSNull) {
            item.currencyId =  JSON(json["currency_id"]!).asString
        }

        if json["category_id"] != nil && !(json["category_id"]! is NSNull) {
            item.categoryId =  JSON(json["category_id"]!).asString
        }

        if json["picture_url"] != nil && !(json["picture_url"]! is NSNull) {
            item.pictureUrl =  JSON(json["picture_url"]!).asString
        }

        return item
    }
}

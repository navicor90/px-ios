//
//  String+Additions.swift
//  MercadoPagoSDK
//
//  Created by Matias Gualino on 29/12/14.
//  Copyright (c) 2014 com.mercadopago. All rights reserved.
//

import Foundation
import MercadoPagoSDK

extension String {

	var localized: String {
		return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
	}

    static public func isNullOrEmpty(_ value: String?) -> Bool {
        return value == nil || value!.isEmpty
    }

	static public func isDigitsOnly(_ a: String) -> Bool {
		if Regex.init("^[0-9]*$").test(a) {
			return true
		} else {
			return false
		}
	}

    public func startsWith(_ prefix: String) -> Bool {
        let startIndex = self.range(of: prefix)
        if startIndex == nil  || self.startIndex != startIndex?.lowerBound {
            return false
        }
        return true
    }

	subscript (i: Int) -> String {

		if self.characters.count > i {
			return String(self[self.characters.index(self.startIndex, offsetBy: i)])
		}

		return ""
	}

	public func indexAt(_ theInt: Int)->String.Index {

		return self.characters.index(self.characters.startIndex, offsetBy: theInt)
	}
}

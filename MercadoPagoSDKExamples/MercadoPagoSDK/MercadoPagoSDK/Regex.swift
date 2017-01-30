//
//  Regex.swift
//  MercadoPagoSDK
//
//  Created by Matias Gualino on 30/1/15.
//  Copyright (c) 2015 com.mercadopago. All rights reserved.
//

import Foundation

public class Regex {
    let internalExpression: NSRegularExpression?
    let pattern: String

    public init(_ pattern: String) {
        self.pattern = pattern
		do {
			self.internalExpression = try NSRegularExpression(pattern: pattern, options: [NSRegularExpressionOptions.CaseInsensitive])
		} catch {
			self.internalExpression = nil
		}
    }

    public func test(input: String) -> Bool {
		if self.internalExpression != nil {
			let matches = self.internalExpression!.matchesInString(input, options: [], range:NSMakeRange(0, input.characters.count))
			return matches.count > 0
		} else {
			return false
		}
    }
}

//
//  Inflator.swift
//  MercadoPagoSDKExamples
//
//  Created by Eden Torres on 2/7/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import Foundation
import MercadoPagoSDK

class CustomInflator: NSObject, MPCustomInflator {
    
    var nib : UINib!
    
    func getNib() -> UINib {
        return UINib(nibName: "CustomTableViewCell", bundle: Bundle.main)
    }
    
    func getHeigth() -> CGFloat {
        return 100.0
    }
    
    func fillCell(cell: MPCustomTableViewCell){
        let customCell = cell as! CustomTableViewCell
        
    }
    
}







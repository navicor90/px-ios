//
//  RejectedTableViewCell.swift
//  MercadoPagoSDK
//
//  Created by Eden Torres on 10/28/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

class RejectedTableViewCell: CallbackCancelTableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitile: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var paymentTypeId: String?;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        button.layer.cornerRadius = 3
        self.title.text = "¿Qué puedo hacer?".localized
        self.title.font = Utils.getFont(size: self.title.font.pointSize)
        self.subtitile.font = Utils.getFont(size: self.subtitile.font.pointSize)
        self.button.addTarget(self, action: #selector(invokeCallback), for: .touchUpInside)
        self.button.setTitle("Pagar con otro medio".localized, for: .normal)
        self.button.titleLabel?.font = Utils.getFont(size: 16)
        self.selectionStyle = .none
    }
    
    func fillCell (paymentResult: PaymentResult){
        
        if paymentResult.status == "rejected"{
            
            if paymentResult.statusDetail == "cc_rejected_call_for_authorize"{
                let title = (paymentResult.statusDetail + "_title")
                self.title.text = title.localized
                self.subtitile.text = ""
            } else {
                
                if let paymentTypeId = paymentResult.paymentData?.paymentMethod.paymentTypeId{
                    self.paymentTypeId = paymentTypeId
                } else {
                    paymentTypeId = "credit_card"
                }
                
                var title = (paymentResult.statusDetail + "_subtitle_" + paymentTypeId!)
                
                if !title.existsLocalized() {
                    title = ""
                }
                self.subtitile.text = title.localized
                if paymentResult.statusDetail.contains("cc_rejected_bad_filled"){
                    status = MPStepBuilder.CongratsState.cancel_RECOVER
                    self.button.setTitle("Ingresalo nuevamente".localized, for: UIControlState.normal)
                }
            }
        } else if paymentResult.status == "in_process" {
            self.title.text = MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getContetTitle()
            
            if !String.isNullOrEmpty(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getContentText()){
                self.subtitile.text = MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getContentText()
            
            } else if paymentResult.statusDetail == "pending_contingency"{
                self.subtitile.text = "En menos de 1 hora te enviaremos por e-mail el resultado.".localized
            
            } else {
                self.subtitile.text = "En menos de 2 días hábiles te diremos por e-mail si se acreditó o si necesitamos más información.".localized
            }
        }
    }
}

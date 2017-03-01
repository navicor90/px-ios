//
//  FinalVaultViewController.swift
//  MercadoPagoSDK
//
//  Created by Matias Gualino on 4/2/15.
//  Copyright (c) 2015 com.mercadopago. All rights reserved.
//

import Foundation
import MercadoPagoSDK

class FinalVaultViewController : AdvancedVaultViewController {
//
//    var finalCallback : ((_ paymentMethod: PaymentMethod, _ token: String?, _ issuer: Issuer?, _ installments: Int) -> Void)?
// 
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//	
//	override init(merchantPublicKey: String, merchantBaseUrl: String, merchantGetCustomerUri: String, merchantAccessToken: String, amount: Double, paymentPreference: PaymentPreference?, callback: ((_ paymentMethod: PaymentMethod, _ token: String?, _ issuer: Issuer?, _ installments: Int) -> Void)?) {
//		super.init(merchantPublicKey: merchantPublicKey, merchantBaseUrl: merchantBaseUrl, merchantGetCustomerUri: merchantGetCustomerUri, merchantAccessToken: merchantAccessToken, amount: amount, paymentPreference: paymentPreference, callback: callback)
//		self.finalCallback = callback
//	}
//   
//    override func getSelectionCallbackPaymentMethod() -> (_ paymentMethod : PaymentMethod) -> Void {
//        return { (paymentMethod : PaymentMethod) -> Void in
//            self.selectedPaymentMethod = paymentMethod
//            if PaymentTypeId(rawValue:paymentMethod.paymentTypeId!)!.isCard() {
//                self.selectedCard = nil
//                if paymentMethod.settings != nil && paymentMethod.settings.count > 0 {
//                    self.securityCodeLength = paymentMethod.settings![0].securityCode!.length
//                    self.securityCodeRequired = self.securityCodeLength != 0
//                }
//                let newCardViewController = MPStepBuilder.startNewCardStep(self.selectedPaymentMethod!, requireSecurityCode: self.securityCodeRequired, callback: self.getNewCardCallback())
//                
//                if self.selectedPaymentMethod!.isIssuerRequired() {
//                    let issuerViewController = MPStepBuilder.startIssuersStep(self.selectedPaymentMethod!,
//                        callback: { (issuer: Issuer) -> Void in
//                            self.selectedIssuer = issuer
//                            self.showViewController(newCardViewController)
//                    })
//                    self.showViewController(issuerViewController)
//                } else {
//                    self.showViewController(newCardViewController)
//                }
//            } else {
//                self.tableview.reloadData()
//                self.navigationController!.popToViewController(self, animated: true)
//            }
//        }
//    }
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        
//        if (self.selectedCard == nil && self.selectedCardToken == nil) || (self.selectedPaymentMethod != nil && !self.selectedPaymentMethod!.isCard()) {
//            return 1
//        }
//        else if self.selectedPayerCost == nil {
//            return 2
//        } else if !securityCodeRequired {
//            return 2
//        }
//        return 3
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if (indexPath as NSIndexPath).row == 0 {
//            if self.selectedCardToken == nil && self.selectedCard == nil && self.selectedPaymentMethod == nil {
//                self.emptyPaymentMethodCell = self.tableview.dequeueReusableCell(withIdentifier: "emptyPaymentMethodCell") as! MPPaymentMethodEmptyTableViewCell
//                return self.emptyPaymentMethodCell
//            } else {
//                self.paymentMethodCell = self.tableview.dequeueReusableCell(withIdentifier: "paymentMethodCell") as! MPPaymentMethodTableViewCell
//                let paymentTypeId = PaymentTypeId(rawValue : self.selectedPaymentMethod!.paymentTypeId!)
//                if !paymentTypeId!.isCard() {
//                    self.paymentMethodCell.fillWithPaymentMethod(self.selectedPaymentMethod!)                    
//                }
//                else if self.selectedCardToken != nil {
//                    self.paymentMethodCell.fillWithCardTokenAndPaymentMethod(self.selectedCardToken, paymentMethod: self.selectedPaymentMethod!)
//                } else {
//                    self.paymentMethodCell.fillWithCard(self.selectedCard)
//                }
//                return self.paymentMethodCell
//            }
//        } else if (indexPath as NSIndexPath).row == 1 {
//            self.installmentsCell = self.tableview.dequeueReusableCell(withIdentifier: "installmentsCell") as! MPInstallmentsTableViewCell
//            self.installmentsCell.fillWithPayerCost(self.selectedPayerCost, amount: self.amount)
//            return self.installmentsCell
//        } else if (indexPath as NSIndexPath).row == 2 {
//            self.securityCodeCell = self.tableview.dequeueReusableCell(withIdentifier: "securityCodeCell") as! MPSecurityCodeTableViewCell
//            self.securityCodeCell.fillWithPaymentMethod(self.selectedPaymentMethod!)
//            self.securityCodeCell.securityCodeTextField.delegate = self
//            return self.securityCodeCell
//        }
//        return UITableViewCell()
//    }

}

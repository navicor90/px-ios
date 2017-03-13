//
//  MainExamplesViewController.h
//  MercadoPagoSDKExamplesObjectiveC
//
//  Created by Maria cristina rodriguez on 1/7/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MercadoPagoSDK;

@interface MainExamplesViewController : UITableViewController

@property MPCustomCell *customCell;
@property CheckoutPreference *pref;
@property PaymentData *paymentData;
@property PaymentResult *paymentResult;
@property MercadoPagoCheckout *mpCheckout;

@property MPCustomCell *dineroEnCuentaCell;

+(void)setPaymentDataCallback;

@end

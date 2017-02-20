//
//  DineroEnCuentaTableViewCell.h
//  MercadoPagoSDKExamplesObjectiveC
//
//  Created by Eden Torres on 2/16/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MercadoPagoSDK;

@interface DineroEnCuentaTableViewCell : UITableViewCell<MPCellContentProvider>
@property (weak, nonatomic) IBOutlet UIButton *button;


@end

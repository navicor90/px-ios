//
//  PendingTableViewCell.h
//  MercadoPagoSDKExamplesObjectiveC
//
//  Created by Eden Torres on 2/15/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@import MercadoPagoSDK;

@interface PendingTableViewCell : UITableViewCell<MPCellContentProvider>
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

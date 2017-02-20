//
//  SubeTableViewCell.m
//  MercadoPagoSDKExamplesObjectiveC
//
//  Created by Eden Torres on 2/15/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

#import "SubeTableViewCell.h"

@implementation SubeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(CGFloat)getHeight {
    return (CGFloat)150;
}

@end

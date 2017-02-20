//
//  CustomItemTableViewCell.m
//  MercadoPagoSDKExamplesObjectiveC
//
//  Created by Maria cristina rodriguez on 2/15/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

#import "CustomItemTableViewCell.h"

@implementation CustomItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(CGFloat)getHeight {
    return (CGFloat)50;
}

- (UINib * _Nonnull)getNib {
    return [UINib nibWithNibName:@"CustomItemTableViewCell" bundle: [NSBundle mainBundle]];
}

@end

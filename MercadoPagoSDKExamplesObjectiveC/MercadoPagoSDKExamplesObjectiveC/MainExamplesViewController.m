//
//  MainExamplesViewController.m
//  MercadoPagoSDKExamplesObjectiveC
//
//  Created by Maria cristina rodriguez on 1/7/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

#import "MainExamplesViewController.h"
#import "ExampleUtils.h"
@import MercadoPagoSDK;


@implementation MainExamplesViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [MercadoPagoContext setPublicKey:TEST_PUBLIC_KEY];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkoutFlow:(id)sender {
    
    Item *item = [[Item alloc] initWith_id:ITEM_ID title:ITEM_TITLE quantity:ITEM_QUANTITY unitPrice:ITEM_UNIT_PRICE description:nil];
    
    
   // MPFlowBuilder startCheckoutViewController:"preferenceid" navigationController:<#(UINavigationController * _Nonnull)#> callback:<#^(Payment * _Nonnull)callback#> callbackCancel:<#^(void)callbackCancel#>
   
       
}


@end

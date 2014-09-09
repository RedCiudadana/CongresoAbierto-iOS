//
//  CommissionViewController.h
//  CongresoAbierto
//
//  Created by David Hsieh on 9/9/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import "ViewController.h"
#import "Commission.h"

@interface CommissionViewController : ViewController


@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *descLB;
@property (weak, nonatomic) IBOutlet UILabel *addressLB;
@property (weak, nonatomic) IBOutlet UILabel *phoneLB;
@property (weak, nonatomic) Commission *commission;


@end

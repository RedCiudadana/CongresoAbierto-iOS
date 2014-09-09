//
//  DiputadoViewController.h
//  CongresoAbierto
//
//  Created by David Hsieh on 7/9/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deputy.h"

@interface DiputadoViewController : UIViewController



@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *districtLB;


@property (weak, nonatomic) IBOutlet UIImageView *pictureIV;

@property (strong, nonatomic) Deputy *deputy;

@property (weak, nonatomic) IBOutlet UIButton *emailBT;
@property (weak, nonatomic) IBOutlet UIButton *votesBT;
@property (weak, nonatomic) IBOutlet UIButton *commissionBT;
@property (weak, nonatomic) IBOutlet UIButton *attendanceBT;

@property (weak, nonatomic) IBOutlet UIButton *callBT;


@end

//
//  DiputadoViewController.m
//  CongresoAbierto
//
//  Created by David Hsieh on 7/9/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import "DiputadoViewController.h"
#import "UIImageView+WebCache.h"

@implementation DiputadoViewController

- (void)viewDidLoad {
    // Navigation bar colors
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.396 green:0.733 blue:0.894 alpha:1.000];
    self.navigationController.navigationBar.translucent = NO;
    
    
    
    self.nameLB.text = self.deputy.name;
    self.districtLB.text = [NSString stringWithFormat:@"%@ | %@", self.deputy.district, self.deputy.actualParty];

    self.emailBT.layer.cornerRadius = 10.0f;
    self.votesBT.layer.cornerRadius = 10.0f;
    self.commissionBT.layer.cornerRadius = 10.0f;
    self.attendanceBT.layer.cornerRadius = 10.0f;
    self.callBT.layer.cornerRadius = 5.0f;
    
    [self.pictureIV sd_setImageWithURL:[NSURL URLWithString:self.deputy.pictureURL] placeholderImage:[UIImage imageNamed:@"PicturePH"]];
    
    
}


- (IBAction)call:(id)sender {
    
    NSString *phNo = [NSString stringWithFormat:@"+502%@", self.deputy.phone];
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Tu dispositivo no puede realizar llamadas" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }

}

@end

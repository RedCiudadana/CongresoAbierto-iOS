//
//  DiputadoViewController.m
//  CongresoAbierto
//
//  Created by David Hsieh on 7/9/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import "DiputadoViewController.h"

@implementation DiputadoViewController

- (void)viewDidLoad {
    // Navigation bar colors
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.396 green:0.733 blue:0.894 alpha:1.000];
    self.navigationController.navigationBar.translucent = NO;
    
    
    
    self.nameLB.text = self.deputy.name;

    
    
    
}

@end

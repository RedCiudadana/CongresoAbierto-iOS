//
//  InitialViewController.m
//  CongresoAbierto
//
//  Created by David Hsieh on 7/8/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import "InitialViewController.h"

@implementation InitialViewController

- (void)viewDidLoad {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    dataManager = [DataManager sharedManager];
    
    [dataManager sendRequest];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dataLoaded)
                                                 name:@"DataReceived"
                                               object:nil];
}

-(void) dataLoaded {
    
    // Remove notification observer
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // Proceed to segue
    [self performSegueWithIdentifier:@"InitialSegue" sender:self];
}




@end

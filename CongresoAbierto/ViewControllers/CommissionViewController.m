//
//  CommissionViewController.m
//  CongresoAbierto
//
//  Created by David Hsieh on 9/9/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import "CommissionViewController.h"

@interface CommissionViewController ()

@end

@implementation CommissionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    _nameLB.text = _commission.name;
    [_nameLB sizeToFit];
    _descLB.text = _commission.info;
    [_descLB sizeToFit];
    _addressLB.text = _commission.address;
    [_addressLB sizeToFit];
    _phoneLB.text = _commission.phoneNumber;
    [_phoneLB sizeToFit];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

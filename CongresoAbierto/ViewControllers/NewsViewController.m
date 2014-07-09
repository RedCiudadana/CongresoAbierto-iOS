//
//  NewsViewController.m
//  CongresoAbierto
//
//  Created by David Hsieh on 7/6/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import "NewsViewController.h"

@implementation NewsViewController

- (void)viewDidLoad {
    
    // Navigation bar colors
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.396 green:0.733 blue:0.894 alpha:1.000];
    self.navigationController.navigationBar.translucent = NO;

    
    
    // Representative Textfield placeholder color
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Distrito, Municipio" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    representativeTF.attributedPlaceholder = str;
    
    // Representative Textfield's border and inset
    representativeTF.layer.cornerRadius=4.0f;
    representativeTF.layer.masksToBounds=YES;
    representativeTF.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    representativeTF.layer.borderWidth= 1.0f;
    representativeTF.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0); // Inset
    representativeTF.delegate = self;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    // Keyboard dismiss tap gesture
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOnTap:)];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:singleTap];
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}







- (void)textFieldDidBeginEditing:(UITextField *)textField {
    currentResponder = textField;
}



- (void)resignOnTap:(id)iSender {
    [currentResponder resignFirstResponder];
}


@end

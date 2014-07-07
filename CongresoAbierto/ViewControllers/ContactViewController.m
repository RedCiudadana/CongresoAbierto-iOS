//
//  ContactViewController.m
//  CongresoAbierto
//
//  Created by David Hsieh on 7/7/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import "ContactViewController.h"

@implementation ContactViewController


- (void)viewDidLoad {
    // Navigation bar colors
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.396 green:0.733 blue:0.894 alpha:1.000];
    self.navigationController.navigationBar.translucent = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    // Representative Textfield placeholder color
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Distrito, Municipio" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    representativeTF.attributedPlaceholder = str;
    
    // Representative Textfield's border and inset
    representativeTF.layer.cornerRadius=4.0f;
    representativeTF.layer.masksToBounds=YES;
    representativeTF.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    representativeTF.layer.borderWidth= 1.0f;
    representativeTF.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0); // Inset
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    
    //  Setup comment textView to mimic textField
    [commentTF.layer setBorderColor:[[UIColor colorWithRed:212.0/255.0
                                                    green:212.0/255.0
                                                     blue:212.0/255.0
                                                    alpha:1] CGColor]];
    [commentTF.layer setBorderWidth:1.0f];
    [commentTF.layer setCornerRadius:7.0f];
    [commentTF.layer setMasksToBounds:YES];
    
    [commentTF setText:@"Comentario"];
    [commentTF setTextColor:[UIColor lightGrayColor]];
    [commentTF setTag:100]; //start tag with default 100
    commentTF.delegate = self;
    
}



- (BOOL) textViewShouldBeginEditing:(UITextView *) textView
{
    if(textView.tag == 100) {
        [textView setTag:200];
        [textView setText:@""];
        [textView setTextColor:[UIColor blackColor]];
    }
         
    return YES;
}
         
- (void) textViewDidEndEditing:(UITextView *) textView
{
    //handle text that has spaces as it's content (i.e. no characters)
    NSString *strStrippedText = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if(strStrippedText.length == 0) {
        [textView setTag:100];
        [textView setText:@"Comentario"];
        [textView setTextColor:[UIColor lightGrayColor]];
     }
}


@end

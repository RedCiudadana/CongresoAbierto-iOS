//
//  DiputadosViewController.h
//  CongresoAbierto
//
//  Created by David Hsieh on 7/7/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKSTableView.h"
#import "SKSTableViewCell.h"



@interface DiputadosViewController : UIViewController <UITextFieldDelegate, SKSTableViewDelegate> {

    __weak IBOutlet UITextField *representativeTF;
    
    id currentResponder;
    
    NSArray *tableContent;

}

@property (nonatomic, weak) IBOutlet SKSTableView *tableView;

@end

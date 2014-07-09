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
#import "Deputy.h"
#import "DataManager.h"



@interface DiputadosViewController : UIViewController <UITextFieldDelegate, SKSTableViewDelegate> {

    __weak IBOutlet UITextField *representativeTF;
    
    id currentResponder;
    
    NSMutableData *receivedData;
    
    NSString *requestURL;
    
    NSArray *districts;
    
    DataManager *dataManager;
    
;

}

@property (nonatomic, strong) NSMutableDictionary *districtDeputies;

@property (nonatomic, strong) IBOutlet SKSTableView *tableView;


@end

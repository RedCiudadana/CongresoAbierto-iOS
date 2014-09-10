//
//  TwitterFeedViewController.h
//  CongresoAbierto
//
//  Created by David Hsieh on 7/7/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STTwitter.h"
#import "BDMessagesKeyboardController.h"
#import "MessageCell.h"

@interface TwitterFeedViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate> {
    
    
    STTwitterAPI *twitter;
    id request;
    
    id currentResponder;
    
    NSString *hashtag;
    

}

@property (nonatomic, strong) NSMutableArray *tweets;
@property (nonatomic, strong) BDMessagesKeyboardController *mKBC;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *dummyTF;


@end

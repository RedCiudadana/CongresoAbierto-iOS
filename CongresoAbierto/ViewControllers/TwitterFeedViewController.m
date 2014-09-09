//
//  TwitterFeedViewController.m
//  CongresoAbierto
//
//  Created by David Hsieh on 7/7/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import "TwitterFeedViewController.h"
#import "TwitterText.h"

@implementation TwitterFeedViewController

- (void)viewDidLoad {
    // Navigation bar colors
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.396 green:0.733 blue:0.894 alpha:1.000];
    self.navigationController.navigationBar.translucent = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
//    twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:@"37dqBxa4H4EJQsxQYJ4K9Px3N"
//                                                          consumerSecret:@"QncEfLV4nv3Cg1VENgQtABifHdTBdH7mMuXifEUmiTo33ZHBiu"
//                                                                username:@""
//                                                                password:@""];
    
//    twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:@"37dqBxa4H4EJQsxQYJ4K9Px3N"
//                                            consumerSecret:@"QncEfLV4nv3Cg1VENgQtABifHdTBdH7mMuXifEUmiTo33ZHBiu"
//                                                oauthToken:@"15628361-15628361-YVeAVhhDJCxmr4PJbxWWs8BFhBgWQb5QazXhW898U"
//                                          oauthTokenSecret:@"PC2ABV4XvYfJmLKEPAJP9Svu84bJ4ulY6oVA6GNdRwiYQ"];

    
    __weak TwitterFeedViewController *weakSelf = self;
    
    twitter = [STTwitterAPI twitterAPIOSWithFirstAccount];
    
    
    _mKBC = [[BDMessagesKeyboardController alloc] init];
    
    _mKBC.styleTextView = ^(UITextView* textView) {
        textView.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
    };
    

    
    _mKBC.styleDoneButton = ^(UIButton* btn){
        btn.backgroundColor = MAIN_THEME_COLOR;
        btn.layer.cornerRadius = 5;
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
//        btn.titleLabel.frame = CGRectMake(btn.titleLabel.frame.size.width, btn.titleLabel.frame.size.height, 20.0f, 10.0f);
        btn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
        [btn addTarget:weakSelf action:@selector(post:) forControlEvents:UIControlEventTouchUpInside];

        
        
    };
    
    _mKBC.shouldDismissKeyboard = ^BOOL(NSString* inputText){
        inputText = [inputText stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" \r\n"]];

        return inputText.length > 0;
    };
    
    
    
    _button.layer.cornerRadius = 5.0f;
    
    _dummyTF.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
    _dummyTF.layer.borderWidth = 1.0f;
    _dummyTF.layer.cornerRadius = 5.0f;
    

    
}



- (IBAction)showMessageKeyboard:(id)sender
{
    [_mKBC showOnViewController:self adjustingScrollView:self.tableView forScrollViewSubview:self.button];
}



- (void)textFieldDidBeginEditing:(UITextField *)textField {
    currentResponder = textField;
}

- (IBAction)verify:(id)sender {
    [twitter verifyCredentialsWithSuccessBlock:^(NSString *username) {
        NSLog(@"Verified %@", username);
    } errorBlock:^(NSError *error) {
        NSLog(@"Err %@", error);
    }];
}

- (IBAction)stream:(id)sender {
    
    twitter = [STTwitterAPI twitterAPIOSWithFirstAccount];
    [twitter verifyCredentialsWithSuccessBlock:^(NSString *username) {
        
        
        
         request = [twitter postStatusesFilterUserIDs:nil
                                        keywordsToTrack:@[@"#tv"]
                                  locationBoundingBoxes:nil
                                              delimited:nil
                                          stallWarnings:nil
                                          progressBlock:^(id response) {
                                              
                                              NSLog(@"progressBlock");
                                              NSLog(@"%@",[((NSDictionary*)response) objectForKey:@"text"]);

                                              
                                          }
                                      stallWarningBlock:^(NSString *code, NSString *message, NSUInteger percentFull) {
                                          NSLog(@"-- stall warning");
                                      }
                                             errorBlock:^(NSError *error) {
                                                 NSLog(@"-- %@", [error localizedDescription]);
                                                 if([[error domain] isEqualToString:NSURLErrorDomain] && [error code] == NSURLErrorNetworkConnectionLost) {
                                                     [self stream:sender];
                                                 }
                                             }
                      ];
        
    } errorBlock:^(NSError *error) {
        //
        NSLog(@"%@", [error localizedDescription]);
    }];
    
//    [request cancel]; // when you're done with it
}

- (IBAction)cancel:(id)sender {
    
    [request cancel];
}

- (void)post:(id)sender {
    NSLog(@"Called post");
    
        [twitter verifyCredentialsWithSuccessBlock:^(NSString *username){
            
            [twitter postStatusUpdate:_mKBC.getText
                    inReplyToStatusID:nil
                             latitude:nil
                            longitude:nil
                              placeID:nil
                   displayCoordinates:nil
                             trimUser:nil
                         successBlock:^(NSDictionary *status) {
                             NSLog(@"Success: %@", status);
                         } errorBlock:^(NSError *error) {
                             NSLog(@"ERR: %@", error);
                         }];
        } errorBlock:^(NSError *error) {
            NSLog(@"-- %@", [error localizedDescription]);
            if([[error domain] isEqualToString:NSURLErrorDomain] && [error code] == NSURLErrorNetworkConnectionLost) {
                [self post:sender];
            }

        }];
    
    
    

}

@end

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

    
    hashtag = @"#CongresoAbiertoGT";
    
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
    

    
    _tweets = [[NSMutableArray alloc] init];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MessageCell";
    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    
    cell.messageLB.text = [[[_tweets objectAtIndex:indexPath.row] objectForKey:@"text"] stringByReplacingOccurrencesOfString:hashtag withString:@""];
    NSString *username = [[[_tweets objectAtIndex:indexPath.row] objectForKey:@"user"] objectForKey:@"name"];
    cell.usernameLB.text = [NSString stringWithFormat:@"%@ dice:", username];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE MMM dd hh:mm:ss Z yyyy"];
    NSDate *date = [dateFormatter dateFromString:[[_tweets objectAtIndex:indexPath.row] objectForKey:@"created_at"]];
    
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    
    NSLog(@"New date: %@", date);
    
    cell.dateLB.text = [dateFormatter stringFromDate:date];
    
    
    [self resizeHeightForLabel:cell.messageLB];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * text = [[_tweets objectAtIndex:indexPath.row] objectForKey:@"text"];
    return 10.0f + [self heightForText:text];
}

-(CGFloat)heightForText:(NSString *)text
{
    NSInteger MAX_HEIGHT = 2000;
    UITextView * textView = [[UITextView alloc] initWithFrame: CGRectMake(0, 0, 273, MAX_HEIGHT)];
    textView.text = text;
    textView.font = [UIFont systemFontOfSize:13.0f];
    [textView sizeToFit];
    return textView.frame.size.height;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
                                        keywordsToTrack:@[hashtag]
                                  locationBoundingBoxes:nil
                                              delimited:nil
                                          stallWarnings:nil
                                          progressBlock:^(id response) {
                                              
                                              NSLog(@"progressBlock");
                                              NSLog(@"%@",((NSDictionary*)response));
                                              

                                              [_tableView beginUpdates];

                                              [_tweets addObject:response];
                                              NSLog(@"tweets size %ld", _tweets.count);
                                              [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_tweets.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                                              [_tableView endUpdates];
                                              [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_tweets.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];

                                              
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
            
            [twitter postStatusUpdate:[NSString stringWithFormat:@"%@ %@", _mKBC.getText, hashtag]
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

-(void)resizeHeightForLabel: (UILabel*)label {
    label.numberOfLines = 0;
    UIView *superview = label.superview;
    [label removeFromSuperview];
    [label removeConstraints:label.constraints];
    CGRect labelFrame = label.frame;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        CGRect expectedFrame = [label.text boundingRectWithSize:CGSizeMake(label.frame.size.width, 9999)
                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                 label.font, NSFontAttributeName,
                                                                 nil]
                                                        context:nil];
        labelFrame.size = expectedFrame.size;
        labelFrame.size.height = ceil(labelFrame.size.height); //iOS7 is not rounding up to the nearest whole number
    } else {
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        labelFrame.size = [label.text sizeWithFont:label.font
                                 constrainedToSize:CGSizeMake(label.frame.size.width, 9999)
                                     lineBreakMode:label.lineBreakMode];
#pragma GCC diagnostic warning "-Wdeprecated-declarations"
    }
    label.frame = labelFrame;
    [superview addSubview:label];

}


@end

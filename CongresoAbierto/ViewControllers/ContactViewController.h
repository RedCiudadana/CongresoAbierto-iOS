//
//  ContactViewController.h
//  CongresoAbierto
//
//  Created by David Hsieh on 7/7/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSKeyboardControls.h"
#import <MessageUI/MessageUI.h>

@interface ContactViewController : UIViewController <BSKeyboardControlsDelegate, UITextViewDelegate, UITextFieldDelegate, MFMailComposeViewControllerDelegate> {
    
    
    __weak IBOutlet UITextField *nameTF;
    
    __weak IBOutlet UITextView *commentTF;
    
    
    __weak IBOutlet UITextField *emailTF;
    
    __weak IBOutlet UIButton *sendBT;
    

    
    
    id currentResponder;
}

@property (nonatomic, strong) BSKeyboardControls *keyboardControls;


@end

//
//  ContactViewController.h
//  CongresoAbierto
//
//  Created by David Hsieh on 7/7/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactViewController : UIViewController <UITextViewDelegate> {
    
    
    __weak IBOutlet UITextField *representativeTF;
    
    __weak IBOutlet UITextView *commentTF;
    
    
}


@end

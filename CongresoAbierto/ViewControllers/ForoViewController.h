//
//  ForoViewController.h
//  CongresoAbierto
//
//  Created by David Hsieh on 7/7/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForoViewController : UIViewController <UITextFieldDelegate> {
    
    __weak IBOutlet UITextField *representativeTF;
    
    id currentResponder;
}

@end

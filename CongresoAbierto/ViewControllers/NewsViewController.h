//
//  NewsViewController.h
//  CongresoAbierto
//
//  Created by David Hsieh on 7/6/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewsViewController : UIViewController <UITextFieldDelegate> {
    
    __weak IBOutlet UITextField *representativeTF;
    
    id currentResponder;
    
}






@end

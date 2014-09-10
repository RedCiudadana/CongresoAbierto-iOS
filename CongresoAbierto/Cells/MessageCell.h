//
//  MessageCell.h
//  CongresoAbierto
//
//  Created by David Hsieh on 9/9/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *usernameLB;
@property (weak, nonatomic) IBOutlet UILabel *messageLB;
@property (weak, nonatomic) IBOutlet UILabel *dateLB;

@end

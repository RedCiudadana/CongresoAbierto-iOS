//
//  CommissionsTableViewCell.m
//  CongresoAbierto
//
//  Created by David Hsieh on 9/9/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import "CommissionsTableViewCell.h"

@implementation CommissionsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

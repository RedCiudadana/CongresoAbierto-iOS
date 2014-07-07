//
//  MenuViewController.m
//  CongresoAbierto
//
//  Created by David Hsieh on 7/6/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import "MenuViewController.h"

@implementation MenuViewController

- (void) viewDidLoad {
    
    // Tableview background color
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.341 green:0.341 blue:0.349 alpha:1.000];
    
    
    //  Selection color
    for (int section = 0; section < [self.tableView numberOfSections]; section++) {
        for (int row = 0; row < [self.tableView numberOfRowsInSection:section]; row++) {
            
            

            
            NSIndexPath* cellPath = [NSIndexPath indexPathForRow:row inSection:section];
            UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:cellPath];
            
            UIView *selectionColor = [[UIView alloc] init];
            
            selectionColor.backgroundColor = [UIColor colorWithRed:0.325 green:0.749 blue:0.910 alpha:1.000];
            
            cell.selectedBackgroundView = selectionColor;
            
        }
    }
    
    
}


- (CGFloat) leftMenuVisibleWidth{
    return 260;
}


-(void) configureMenuButton:(UIButton *)menuButton{
    menuButton.frame = CGRectMake(0, 0, 40, 29);
    UIImage *menuIcon = [UIImage imageNamed:@"MenuIcon"];
    [menuButton setImage:menuIcon forState:UIControlStateNormal];

    tableView.backgroundView = nil;
    tableView.backgroundColor = [UIColor colorWithRed:0.349 green:0.349 blue:0.357 alpha:1.000];

}

@end

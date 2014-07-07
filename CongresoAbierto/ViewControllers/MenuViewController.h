//
//  MenuViewController.h
//  CongresoAbierto
//
//  Created by David Hsieh on 7/6/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import "SASlideMenuViewController.h"

@interface MenuViewController : SASlideMenuViewController <SASlideMenuDelegate, SASlideMenuDataSource> {
    
    
    IBOutlet UITableView *tableView;
}



@end

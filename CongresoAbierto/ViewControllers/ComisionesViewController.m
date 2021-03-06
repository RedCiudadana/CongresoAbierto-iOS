//
//  ComisionesViewController.m
//  CongresoAbierto
//
//  Created by David Hsieh on 7/7/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import "ComisionesViewController.h"
#import "CommissionViewController.h"
#import "CommissionsTableViewCell.h"

@implementation ComisionesViewController

- (void)viewDidLoad {
    // Navigation bar colors
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.396 green:0.733 blue:0.894 alpha:1.000];
    self.navigationController.navigationBar.translucent = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    

    DataManager *dataManager = [DataManager sharedManager];
    _commissions = dataManager.commissions;
    

}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    currentResponder = textField;
}




#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _commissions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CommissionCell";
    
    CommissionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[CommissionsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Commission *commission =  [_commissions objectAtIndex:indexPath.row];
    
    cell.nameLB.text = commission.name;
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"viewCommission" sender:indexPath];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([[segue identifier] isEqualToString:@"viewCommission"])
    {
        // Get reference to the destination view controller
        CommissionViewController *vc = [segue destinationViewController];
        
        NSIndexPath *indexPath = sender;
        
        Commission *commission = [[[DataManager sharedManager] commissions] objectAtIndex:indexPath.row];
        
        
        vc.commission = commission;
        
//        NSLog(@"Commision %@", commission);
        
        
        
        
    }
    
}





@end

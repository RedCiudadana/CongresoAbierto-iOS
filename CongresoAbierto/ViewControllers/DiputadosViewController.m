//
//  DiputadosViewController.m
//  CongresoAbierto
//
//  Created by David Hsieh on 7/7/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import "DiputadosViewController.h"

@implementation DiputadosViewController


- (void)viewDidLoad {
    
    // Navigation bar colors
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.396 green:0.733 blue:0.894 alpha:1.000];
    self.navigationController.navigationBar.translucent = NO;



    
    // Keyboard dismiss tap gesture
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOnTap:)];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setNumberOfTouchesRequired:1];
//    [self.view addGestureRecognizer:singleTap];
//    
//    self.tableView.SKSTableViewDelegate = self;
//    self.tableView.shouldExpandOnlyOneCell = YES;
    
    
    // Get DataManager
    dataManager = [DataManager sharedManager];
    
    self.districtDeputies = dataManager.districtDeputies;
    districts = dataManager.districts;
    
    NSLog(@"DD: %@", self.districtDeputies );
    





    
}



- (void)textFieldDidBeginEditing:(UITextField *)textField {
    currentResponder = textField;
}



- (void)resignOnTap:(id)iSender {
    [currentResponder resignFirstResponder];
}





#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    
    return _districtDeputies.count;
}

//- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
//{
//    return ((NSMutableArray*)[_districtDeputies objectForKey:[districts objectAtIndex:indexPath.row]]).count -1;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"SKSTableViewCell";
    
//    SKSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    if (!cell)
//        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    

    
//    if (((NSMutableArray*)[_districtDeputies objectForKey:[districts objectAtIndex:indexPath.row]]).count > 0)
//        cell.expandable = YES;
//    else
//        cell.expandable = NO;

    static NSString *CellIdentifier = @"DistrictCell";
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    

    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cell.textLabel.text = [districts objectAtIndex:indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"Section: %d, Row:%d, Subrow:%d", indexPath.section, indexPath.row, indexPath.subRow);
    [self performSegueWithIdentifier:@"viewDeputies" sender:indexPath];
}


//
//- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"Section: %d, Row:%d, Subrow:%d", indexPath.section, indexPath.row, indexPath.subRow);
//    
//    [self performSegueWithIdentifier:@"ViewDeputy" sender:indexPath];
//}

#pragma mark - Actions

//- (void)collapseSubrows
//{
//    [self.tableView collapseCurrentlyExpandedIndexPaths];
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {


    if ([[segue identifier] isEqualToString:@"viewDeputies"])
    {
        // Get reference to the destination view controller
        DeputiesViewController *vc = [segue destinationViewController];
        
        NSIndexPath *indexPath = sender;
        
        NSArray *districtDeputies = [self.districtDeputies objectForKey:districts[indexPath.row]];
   
        
        vc.districtDeputies = districtDeputies;
        

        
        


    }
    
}






@end






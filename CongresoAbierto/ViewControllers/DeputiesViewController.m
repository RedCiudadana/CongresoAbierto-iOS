//
//  DeputiesViewController.m
//  CongresoAbierto
//
//  Created by David Hsieh on 9/8/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import "DeputiesViewController.h"
#import "DiputadoViewController.h"
#import "Deputy.h"

@interface DeputiesViewController ()

@end

@implementation DeputiesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"Deputies: %@", self.districtDeputies);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.districtDeputies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"DeputyCell";
    
    DeputyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[DeputyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Deputy *deputy = ((Deputy*)[self.districtDeputies objectAtIndex:indexPath.row]);
    
    cell.deputyNameLB.text = [deputy.name uppercaseString];
    cell.deputyPartyLB.text =  deputy.actualParty;
    
//    if (deputy.pictureURL != NULL && ![deputy.pictureURL isEqualToString:@""]) {
    [cell.deputyPicture sd_setImageWithURL:[NSURL URLWithString:deputy.pictureURL] placeholderImage:[UIImage imageNamed:@"PicturePH.png"]    ];


//    }
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"viewDeputy" sender:indexPath];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([[segue identifier] isEqualToString:@"viewDeputy"])
    {
        // Get reference to the destination view controller
        DiputadoViewController *vc = [segue destinationViewController];
        
        NSIndexPath *indexPath = sender;
        

        
        Deputy *deputy = [_districtDeputies objectAtIndex:indexPath.row];
        
        vc.deputy = deputy;
        
        NSLog(@"SENDER: %@", deputy.name);
        
        
        
        
    }
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

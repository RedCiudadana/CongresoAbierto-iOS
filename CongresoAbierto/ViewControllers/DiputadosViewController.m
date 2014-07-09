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
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    // Representative Textfield placeholder color
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Distrito, Municipio" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    representativeTF.attributedPlaceholder = str;
    
    // Representative Textfield's border and inset
    representativeTF.layer.cornerRadius=4.0f;
    representativeTF.layer.masksToBounds=YES;
    representativeTF.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    representativeTF.layer.borderWidth= 1.0f;
    representativeTF.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0); // Inset
    representativeTF.delegate = self;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // Keyboard dismiss tap gesture
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOnTap:)];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setNumberOfTouchesRequired:1];
//    [self.view addGestureRecognizer:singleTap];
    
    
    self.tableView.SKSTableViewDelegate = self;
    self.tableView.shouldExpandOnlyOneCell = YES;


    // Send request to retreive diputados from backend
    [self sendRequest];
    
    districts = @[@"Alta Verapaz",
                  @"Baja Verapaz",
                  @"Chimaltenango",
                  @"Chiquimula",
                  @"Diputado por Listado Nacional",
                  @"Distrito Central",
                  @"Distrito Guatemala",
                  @"El Progreso",
                  @"Escuintla",
                  @"Huehuetenango",
                  @"Izabal",
                  @"Jalapa",
                  @"Jutiapa",
                  @"Petén",
                  @"Quetzaltenango",
                  @"Quiché",
                  @"Retalhuleu",
                  @"Sacatepéquez",
                  @"San Marcos",
                  @"Santa Rosa",
                  @"Sololá",
                  @"Suchitepéquez",
                  @"Totonicapán",
                  @"Zacapa"];
    
    _districtDeputies = [[NSMutableDictionary alloc] init];
    
    for (NSString *district in districts) {
        [_districtDeputies setObject:[[NSMutableArray alloc] init] forKey:district];
    }

    
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

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    return ((NSMutableArray*)[_districtDeputies objectForKey:[districts objectAtIndex:indexPath.row]]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKSTableViewCell";
    
    SKSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cell.textLabel.text = [districts objectAtIndex:indexPath.row];
    
    if (((NSMutableArray*)[_districtDeputies objectForKey:[districts objectAtIndex:indexPath.row]]).count > 0)
        cell.expandable = YES;
    else
        cell.expandable = NO;
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    Deputy *currentDeputy = (Deputy*)[((NSMutableArray*)[_districtDeputies objectForKey:[districts objectAtIndex:indexPath.row]]) objectAtIndex:indexPath.subRow];
    
    cell.textLabel.text = currentDeputy.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Section: %d, Row:%d, Subrow:%d", indexPath.section, indexPath.row, indexPath.subRow);
}



- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Section: %d, Row:%d, Subrow:%d", indexPath.section, indexPath.row, indexPath.subRow);
}

#pragma mark - Actions

- (void)collapseSubrows
{
    [self.tableView collapseCurrentlyExpandedIndexPaths];
}


- (void) sendRequest {
    
    receivedData = [[NSMutableData alloc] init];
    NSLog(@"Initial data length: %lu",(unsigned long)[receivedData length]);
    
    
    requestURL =[NSString stringWithFormat:@"http://54.186.114.101:3000/listado.json"];
    
    
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:requestURL]];
    [request setHTTPMethod:@"GET"];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    NSLog(@"connection Started");
    
}



#pragma mark -
#pragma mark NSURLConnection Delegates

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Failed with error: %@", error.description);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    int responseCode = (int)((NSHTTPURLResponse*)response).statusCode;
    NSLog(@"Response: %d", responseCode );
    
    
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSError *error;
    
    // Print the raw response
//    NSLog(@"Data string: %@", [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding]);


    
    
    NSLog(@"Connection did finish loading");


    NSArray* json = [NSJSONSerialization
                          JSONObjectWithData:receivedData
                          options:NSUTF8StringEncoding
                          error:&error];

    if (error) {
        NSLog(@"Parsing error: %@", error.description);
    }

    for (NSDictionary *deputyDictionary  in json) {
        
        NSLog(@"WHAT");
        
        NSString *currentDistrict = [self cleanStringFromString:[deputyDictionary objectForKey:@"distrito"]];
        
        NSMutableArray *districtDeputyArray = [_districtDeputies objectForKey:currentDistrict];
        
        NSLog(@"Current district %@", currentDistrict);
        

        
        Deputy *deputy = [[Deputy alloc] initWithDictionary:deputyDictionary];
        
        [districtDeputyArray addObject:deputy];
        [_districtDeputies setObject:districtDeputyArray forKey:currentDistrict];
        
    }
    
    NSLog(@"Deputy count %lu", (unsigned long)[_districtDeputies count]);

    [self.tableView reloadData];

}

- (NSString *)cleanStringFromString:(NSString *)string {
    
    NSString *cleanString = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    cleanString = [cleanString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    cleanString = [cleanString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return cleanString;
    
}





@end






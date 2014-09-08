//
//  DataManager.m
//  CongresoAbierto
//
//  Created by David Hsieh on 7/8/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

@synthesize someProperty;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static DataManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
 

        
        _districts = @[@"Alta Verapaz",
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
        
        for (NSString *district in _districts) {
            [_districtDeputies setObject:[[NSMutableArray alloc] init] forKey:district];
        }
        
    }
    return self;
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
        
//        NSLog(@"WHAT");
        
        NSString *currentDistrict = [self cleanStringFromString:[deputyDictionary objectForKey:@"distrito"]];
        
        NSMutableArray *districtDeputyArray = [_districtDeputies objectForKey:currentDistrict];
        
//        NSLog(@"Current district %@", currentDistrict);
        
        
        
        Deputy *deputy = [[Deputy alloc] initWithDictionary:deputyDictionary];
        
        [districtDeputyArray addObject:deputy];
        [_districtDeputies setObject:districtDeputyArray forKey:currentDistrict];
        
    }
    
//    NSLog(@"Deputy count %lu", (unsigned long)[_districtDeputies count]);
    
 [[NSNotificationCenter defaultCenter] postNotificationName:@"DataReceived" object:nil];
    

    
}

- (NSString *)cleanStringFromString:(NSString *)string {
    
    NSString *cleanString = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    cleanString = [cleanString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    cleanString = [cleanString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return cleanString;
    
}


@end

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
        _commissions = [[NSMutableArray alloc] init];
        
        for (NSString *district in _districts) {
            [_districtDeputies setObject:[[NSMutableArray alloc] init] forKey:district];
        }
        
        deputiesRequestURL =[NSString stringWithFormat:@"http://54.186.114.101:3000/listado.json"];
        commissionsRequestURL = @"http://54.186.114.101:3000/listado_comisiones.json";
        

        
    }
    return self;
}


- (void) requestDeputies {
    
    
    
    deputiesReceivedData = [[NSMutableData alloc] init];
    NSLog(@"Initial data length: %lu",(unsigned long)[deputiesReceivedData length]);

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:deputiesRequestURL]];
    [request setHTTPMethod:@"GET"];
    deputiesConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [deputiesConnection start];
    NSLog(@"connection Started");
    
}


- (void) requestCommissions {
    
    
    
    commissionsReceivedData = [[NSMutableData alloc] init];
    NSLog(@"Initial data length: %lu",(unsigned long)[commissionsReceivedData length]);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:commissionsRequestURL]];
    [request setHTTPMethod:@"GET"];
    commissionsConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [deputiesConnection start];
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
    
    if (connection == deputiesConnection) {
        [deputiesReceivedData appendData:data];
    } else if (connection == commissionsConnection) {
        [commissionsReceivedData appendData:data];
    }
    

}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSError *error;
    
    // Print the raw response
    //    NSLog(@"Data string: %@", [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding]);
    
    
    
    
    NSLog(@"Connection did finish loading");
    
    if (connection == deputiesConnection) {
    
    
    NSArray* json = [NSJSONSerialization
                     JSONObjectWithData:deputiesReceivedData
                     options:NSUTF8StringEncoding
                     error:&error];
    
    if (error) {
        NSLog(@"Parsing error: %@", error.description);
    }
    
    for (NSDictionary *deputyDictionary  in json) {

        NSString *currentDistrict = [self cleanStringFromString:[deputyDictionary objectForKey:@"distrito"]];
        
        NSMutableArray *districtDeputyArray = [_districtDeputies objectForKey:currentDistrict];
        
        Deputy *deputy = [[Deputy alloc] initWithDictionary:deputyDictionary];
        
        [districtDeputyArray addObject:deputy];
        [_districtDeputies setObject:districtDeputyArray forKey:currentDistrict];
        
    }
    
//    NSLog(@"Deputy count %lu", (unsigned long)[_districtDeputies count]);
    
 [[NSNotificationCenter defaultCenter] postNotificationName:@"DataReceived" object:nil];
        
    } else if (connection == commissionsConnection) {
        
        
        
        NSArray* json = [NSJSONSerialization
                         JSONObjectWithData:commissionsReceivedData
                         options:NSUTF8StringEncoding
                         error:&error];
        
        if (error) {
            NSLog(@"Parsing error: %@", error.description);
        }
        
        for (NSDictionary *commissionDictionary  in json) {
            
            
            Commission *commission = [[Commission alloc] initWithDictionary:commissionDictionary];
            
            [_commissions addObject:commission];
            

            
        }
        

        
    }
    

    
}

- (NSString *)cleanStringFromString:(NSString *)string {
    
    NSString *cleanString = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    cleanString = [cleanString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    cleanString = [cleanString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return cleanString;
    
}


@end

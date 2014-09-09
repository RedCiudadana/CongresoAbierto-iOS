//
//  DataManager.h
//  CongresoAbierto
//
//  Created by David Hsieh on 7/8/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deputy.h"
#import "Commission.h"

@interface DataManager : NSObject {

    NSString *deputiesRequestURL;
    NSString *commissionsRequestURL;
    
    
    NSMutableData *deputiesReceivedData;
    NSMutableData *commissionsReceivedData;
    
    NSURLConnection *deputiesConnection;
    NSURLConnection *commissionsConnection;
    

    
}

@property (nonatomic, retain) NSString *someProperty;
@property (nonatomic, strong) NSArray *districts;
@property (nonatomic, strong) NSMutableArray *commissions;

@property (nonatomic, strong) NSMutableDictionary *districtDeputies;



+ (id)sharedManager;
- (void) requestDeputies;
- (void) requestCommissions;


@end

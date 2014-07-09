//
//  DataManager.h
//  CongresoAbierto
//
//  Created by David Hsieh on 7/8/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deputy.h"

@interface DataManager : NSObject {
    NSString *someProperty;
    NSString *requestURL;
    
    
    NSMutableData *receivedData;
    
    

    
}

@property (nonatomic, retain) NSString *someProperty;
@property (nonatomic, strong) NSArray *districts;

@property (nonatomic, strong) NSMutableDictionary *districtDeputies;



+ (id)sharedManager;
- (void) sendRequest;


@end

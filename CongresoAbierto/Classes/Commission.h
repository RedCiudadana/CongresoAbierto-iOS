//
//  Commission.h
//  CongresoAbierto
//
//  Created by David Hsieh on 9/8/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Commission : NSObject

@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *ext;
@property (nonatomic, strong) NSString *address;
@property BOOL active;

- (id) initWithDictionary:(NSDictionary*)dictionary;

@end

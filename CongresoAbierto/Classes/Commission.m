//
//  Commission.m
//  CongresoAbierto
//
//  Created by David Hsieh on 9/8/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import "Commission.h"

@implementation Commission

- (id) initWithDictionary:(NSDictionary*)dictionary {
    
    if (self = [super init]) {
        self.phoneNumber = [dictionary objectForKey:@"telefono"];
        self.info = [dictionary objectForKey:@"descripcion"];
        self.name = [dictionary objectForKey:@"nombre"];
        self.ext = [dictionary objectForKey:@"ext"];
        self.active = [[dictionary objectForKey:@"activa"] boolValue];
    }
    
    return self;
    
}

@end

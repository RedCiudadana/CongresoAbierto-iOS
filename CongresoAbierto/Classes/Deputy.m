//
//  Deputy.m
//  CongresoAbierto
//
//  Created by David Hsieh on 7/8/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import "Deputy.h"

@implementation Deputy


// Initialize from given dictionary
- (id)initWithDictionary:(NSDictionary*) dictionary {
    
    if (self = [super init]) {
        
        self.deputyID = [[dictionary objectForKey:@"id"] intValue];
        if ([dictionary objectForKey:@"direccion"]  && [dictionary objectForKey:@"direccion"] != [NSNull null])
            self.address = [self cleanStringFromString:[dictionary objectForKey:@"direccion"]];
        if ([dictionary objectForKey:@"twitter"]  && [dictionary objectForKey:@"twitter"] != [NSNull null])
            self.twitter = [self cleanStringFromString:[dictionary objectForKey:@"twitter"]];
        
        if ([dictionary objectForKey:@"telefono"] && [dictionary objectForKey:@"telefono"] != [NSNull null])
            self.phone =  [self cleanStringFromString:[dictionary objectForKey:@"telefono"]];
        

        if ([dictionary objectForKey:@"correo"] && [dictionary objectForKey:@"correo"] != [NSNull null])
            self.email = [self cleanStringFromString:[dictionary objectForKey:@"correo"]];
        

        if ([dictionary objectForKey:@"url_foto"] && [dictionary objectForKey:@"url_foto"] != [NSNull null])
            self.pictureURL = [self cleanStringFromString:[dictionary objectForKey:@"url_foto"]];
        
        if ([dictionary objectForKey:@"ext"] && [dictionary objectForKey:@"ext"] != [NSNull null])
            self.extension = [self cleanStringFromString:[dictionary objectForKey:@"ext"]];
        

        if ([dictionary objectForKey:@"distrito"] && [dictionary objectForKey:@"distrito"] != [NSNull null])
            self.district = [self cleanStringFromString:[dictionary objectForKey:@"distrito"]];
        

        if ([dictionary objectForKey:@"state"] && [dictionary objectForKey:@"state"] != [NSNull null])
            self.state = [self cleanStringFromString:[dictionary objectForKey:@"state"]];
        

        if ([dictionary objectForKey:@"partido_postulante"] && [dictionary objectForKey:@"partido_postulante"] != [NSNull null])
            self.postulantParty = [self cleanStringFromString:[dictionary objectForKey:@"partido_postulante"]];
        

        if ([dictionary objectForKey:@"partido_actual"] && [dictionary objectForKey:@"partido_actual"] != [NSNull null])
            self.actualParty = [self cleanStringFromString:[dictionary objectForKey:@"partido_actual"]];
        

        if ([dictionary objectForKey:@"nombre"] && [dictionary objectForKey:@"nombre"] != [NSNull null])
            self.name = [self cleanStringFromString:[dictionary objectForKey:@"nombre"]];
        

        if ([dictionary objectForKey:@"departamento"] && [dictionary objectForKey:@"departamento"] != [NSNull null])
            self.department = [self cleanStringFromString:[dictionary objectForKey:@"departamento"]];
        

        if ([dictionary objectForKey:@"facebook"] && [dictionary objectForKey:@"facebook"] != [NSNull null])
            self.facebook = [self cleanStringFromString:[dictionary objectForKey:@"facebook"]];
        

        
        
    }
    
    
    return self;
    
    
}

- (NSString *)cleanStringFromString:(NSString *)string {
    
    NSString *cleanString = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    cleanString = [cleanString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    cleanString = [cleanString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return cleanString;

}

@end

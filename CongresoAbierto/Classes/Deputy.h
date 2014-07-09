//
//  Deputy.h
//  CongresoAbierto
//
//  Created by David Hsieh on 7/8/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Deputy : NSObject

@property int deputyID;
@property (nonatomic, strong) NSString *postulantParty;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *twitter;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *pictureURL;
@property (nonatomic, strong) NSString *extension;
@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *actualParty;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *department;
@property (nonatomic, strong) NSString *facebook;

- (id)initWithDictionary:(NSDictionary*) dictionary;

@end

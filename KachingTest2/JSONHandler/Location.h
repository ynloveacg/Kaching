//
//  Location.h
//  JSONHandler
//
//  Created by Ni Yan on 10/5/14.
//  Copyright (c) 2014 Dada Beatnik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary;

@property (readonly) NSString *name;
@property (readonly) NSString *category;
@property (readonly) NSNumber *latitude;
@property (readonly) NSNumber *longitude;
@property (readonly) NSString *discount;
@property (readonly) NSString *phone;
@property (readonly) NSString *websiteurl;

@end

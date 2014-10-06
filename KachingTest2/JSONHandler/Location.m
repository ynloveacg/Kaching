//
//  Location.m
//  JSONHandler
//
//  Created by Ni Yan on 10/5/14.
//  Copyright (c) 2014 Dada Beatnik. All rights reserved.
//

#import "Location.h"

@implementation Location

// Init the object with information from a dictionary
- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary {
    if(self = [self init]) {
        // Assign all properties with keyed values from the dictionary
        _name = [jsonDictionary objectForKey:@"name"];
        _category = [jsonDictionary objectForKey:@"category"];
        _discount = [jsonDictionary objectForKey:@"discount"];
        _phone = [jsonDictionary objectForKey:@"phone"];
        _latitude = [jsonDictionary valueForKeyPath:@"location_1.latitude"];
        _longitude = [jsonDictionary valueForKeyPath:@"location_1.longitude"];
        _websiteurl = [jsonDictionary objectForKey:@"websiteurl"];
        //_visited = [jsonDictionary objectForKey:@"visited"];
    }
    
    return self;
}

@end

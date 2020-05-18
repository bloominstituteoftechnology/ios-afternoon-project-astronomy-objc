//
//  SSSCodableObject.m
//  FavoriteArtists
//
//  Created by Shawn Gee on 5/18/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import "SSSCodableObject.h"
#import "objc/runtime.h"

@implementation SSSCodableObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        
        for (NSString *codingKey in [self.codingKeys keyEnumerator]) {
            
            NSString *key = [self.codingKeys objectForKey:codingKey];
            id value = [dictionary objectForKey:key];
            
            // Transform NSNull into nil, applies when JSON key is present but value is NULL
            if ([value isKindOfClass:[NSNull class]]) {
                value = nil;
            }

            [self setValue:value forKey:codingKey];
        }
    }
    
    return self;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    for (NSString *codingKey in [self.codingKeys keyEnumerator]) {
        
        NSString *key = [self.codingKeys objectForKey:codingKey];
        id value = [self valueForKey:codingKey];
        [dictionary setValue:value forKey:key];
    }
    
    return [dictionary copy];
}

- (NSDictionary *)codingKeys {
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    
    NSMutableDictionary *codingKeys = [[NSMutableDictionary alloc] init];
    
    for (unsigned int i = 0; i < propertyCount; ++i) {
        objc_property_t property = properties[i];
        const char * name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        [codingKeys setObject:propertyName forKey:propertyName];
    }
    
    free(properties);
    
    return [codingKeys copy];
}


@end

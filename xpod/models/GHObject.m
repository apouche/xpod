//
//  GHObject.m
//  xpod
//
//  Created by Johan on 19/05/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

#import "GHObject.h"

@implementation GHObject

#pragma mark - Mantle

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"objectID": @"id",
             @"name" : @"name"
             };
}

@end

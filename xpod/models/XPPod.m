//
//  XPPod.m
//  xpod
//
//  Created by Johan on 16/05/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

#import "XPPod.h"

@implementation XPPod

- (id)initWithYAMLDictionary:(NSDictionary *)dictionary name:(NSString*)name {
    if (self = [super init]) {
        self.name = name;
    }
    return self;
}

@end

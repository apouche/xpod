//
//  XPPod.m
//  xpod
//
//  Created by Johan on 16/05/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

#import "XPPod.h"

const NSString* kXPPodSourceKey = @"src";
const NSString* kXPPodURLKey = @"url";
const NSString* kXPPodArchitecturesKey = @"archs";

@implementation XPPod

- (id)initWithYAMLDictionary:(NSDictionary *)dictionary name:(NSString*)name {
    if (self = [super init]) {
        self.name = name;
        self.url = [NSURL URLWithString:dictionary[kXPPodURLKey]];
        self.sourcePattern = dictionary[kXPPodSourceKey];
        
        id archs = dictionary[kXPPodArchitecturesKey];
        if ([archs isKindOfClass:[NSArray class]])
            self.architectures = archs;
        else if ([archs isKindOfClass:[NSString class]])
            self.architectures = @[archs];
    }
    return self;
}

@end

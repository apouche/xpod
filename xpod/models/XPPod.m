//
//  XPPod.m
//  xpod
//
//  Created by Johan on 16/05/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

#import "XPPod.h"

const NSString* kXPPodSourceKey = @"src";
const NSString* kXPPodURLKey = @"git";

@implementation XPPod

- (id)initWithYAMLDictionary:(NSDictionary *)dictionary name:(NSString*)name {
    if (self = [super init]) {
        self.name = name;
        self.url = [NSURL URLWithString:dictionary[kXPPodURLKey]];
        self.sourcePattern = dictionary[kXPPodSourceKey];
    }
    return self;
}

@end

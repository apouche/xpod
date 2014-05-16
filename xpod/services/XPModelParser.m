//
//  XPModelParser.m
//  xpod
//
//  Created by Johan on 16/05/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

// Libs
#import "YAMLKit.h"
#import "BlocksKit.h"

#import "XPModelParser.h"
#import "XPPod.h"

NSString* kXPModelParserPodsKey = @"pods";

@implementation XPModelParser

- (NSArray *)podsFromYAMLString:(NSString *)yamlString {
    NSDictionary* yamlDict = [YAMLKit loadFromString:yamlString];
    NSDictionary* podsDict = [yamlDict objectForKey:kXPModelParserPodsKey];
    
    NSArray* pods = [[podsDict allKeys] bk_map:^id(NSString* podName) {
        XPPod* pod = [[XPPod alloc] initWithYAMLDictionary:podsDict[podName] name:podName];
        return pod;
    }];
    
    return pods;
}

@end

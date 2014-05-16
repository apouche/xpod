//
//  XPModelParser.m
//  xpod
//
//  Created by Johan on 16/05/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

#import "XPModelParser.h"
#import "YAMLKit.h"
#import "XPObject.h"

NSString* kXPModelParserPodsKey = @"pods";

@implementation XPModelParser

- (NSArray *)podsFromYAMLString:(NSString *)yamlString {
    NSDictionary* yamlDict = [YAMLKit loadFromString:yamlString];
    NSDictionary* podsDict = [yamlDict objectForKey:kXPModelParserPodsKey];
    
    return podsDict.allKeys;
}

@end

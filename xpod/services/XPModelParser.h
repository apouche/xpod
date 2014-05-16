//
//  XPModelParser.h
//  xpod
//
//  Created by Johan on 16/05/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* kXPModelParserPodsKey;

@interface XPModelParser : NSObject

- (NSArray*)podsFromYAMLString:(NSString*)yamlString;

@end

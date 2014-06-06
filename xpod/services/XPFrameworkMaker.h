//
//  XPFrameworkMaker.h
//  xpod
//
//  Created by Maxime Bokobza on 06/06/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XPFrameworkMaker : NSObject

- (void)buildFrameworkAtPath:(NSString *)path withLibs:(NSString *)libs sourcesHeaders:(NSString *)headers;

@end

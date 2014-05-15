//
//  XPTestHelper.h
//  xpod
//
//  Created by Johan on 15/05/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XPTestHelper : NSObject
+ (instancetype)sharedHelper;

#pragma mark Files
- (NSString*)filePathWithName:(NSString*)name;
- (NSString*)fileContentWithName:(NSString*)name;

@end

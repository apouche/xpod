//
//  NSTask+XPPod.h
//  xpod
//
//  Created by Maxime Bokobza on 02/06/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTask (XPPod)

+ (NSString *)launchTaskWithLaunchPath:(NSString *)launchPath arguments:(NSArray *)arguments;
+ (NSString *)launchTaskFromDirectory:(NSString *)currentDirectory withLaunchPath:(NSString *)launchPath arguments:(NSArray *)arguments;
+ (NSArray *)filenamesInDirectory:(NSString *)directory ofType:(NSString *)extension;
+ (void)createDirectory:(NSString *)directory;

@end

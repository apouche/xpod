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
+ (NSArray *)filesPathInDirectory:(NSString *)directory ofType:(NSString *)extension;
+ (void)copyFiles:(NSArray *)files toDirectory:(NSString *)destinationDirectory;
+ (void)createDirectory:(NSString *)directory;
+ (void)symlinkInDirectory:(NSString *)baseDirectory fromFile:(NSString *)fromFile toFile:(NSString *)toFile;

@end

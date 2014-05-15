//
//  XPTestHelper.m
//  xpod
//
//  Created by Johan on 15/05/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

#import "XPTestHelper.h"

@implementation XPTestHelper

+ (instancetype)sharedHelper {
    static XPTestHelper* testHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        testHelper = [[XPTestHelper alloc] init];
    });
    return testHelper;
}

#pragma mark - Files

- (NSString*)filePathWithName:(NSString*)name {
    NSString* resourcePath = [[NSBundle bundleForClass:[self class]] resourcePath];
    NSString* testFilePath = [resourcePath stringByAppendingPathComponent:name];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:testFilePath])
        return testFilePath;
    
    return nil;
}

- (NSString*)fileContentWithName:(NSString*)name {
    NSString* filePath = [self filePathWithName:name];
    NSData* fileData = [[NSFileManager defaultManager] contentsAtPath:filePath];
    if (fileData)
        return [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];

    return nil;
}

@end

//
//  XPTestCompiler.m
//  xpod
//
//  Created by Maxime Bokobza on 02/06/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

// Libs
#import <XCTest/XCTest.h>

// Services
#import "XPCompiler.h"

// Model
#import "XPPod.h"


@interface XPTestCompiler : XCTestCase

@property (nonatomic, strong) XPCompiler *compiler;

@end

@implementation XPTestCompiler

- (void)setUp {
    [super setUp];
    
    self.compiler = [[XPCompiler alloc] init];
}

- (void)tearDown {
    [super tearDown];
    
    [[NSFileManager defaultManager] removeItemAtPath:@"/tmp/xpod" error:nil];
}

- (void)testCompiler {
    XPPod *pod = [[XPPod alloc] init];
    pod.name = @"AFNetworking";
    pod.architectures = @[@"armv7", @"armv7s", @"arm64"];
    
    self.compiler.podRootDirectory = @"/tmp/xpod";
    
    NSString *currentDir = [[NSFileManager defaultManager] currentDirectoryPath];
    NSString *sourceDir = [currentDir stringByAppendingPathComponent:@"xpod-specs/sources/AFNetworking"];
    [self.compiler compilePod:pod sourceDirectory:sourceDir podArchitectureOnly:NO];
    
    for (NSString *arch in [pod.architectures arrayByAddingObjectsFromArray:@[@"i386", @"x86_64"]]) {
        NSString *path = [NSString stringWithFormat:@"%@/%@_%@.a", [self.compiler.podRootDirectory stringByAppendingPathComponent:kLibsDirectory], pod.name, arch];
        XCTAssert([[NSFileManager defaultManager] fileExistsAtPath:path], @"pod arch mismatched");
    }
}

@end


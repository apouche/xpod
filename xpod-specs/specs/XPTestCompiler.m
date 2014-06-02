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
}

- (void)testCompiler {
    XPPod *pod = [[XPPod alloc] init];
    pod.name = @"AFNetworking";
    pod.architectures = @[@"armv7", @"armv7s", @"arm64"];
    
    self.compiler.podRootDirectory = @"./";
    [self.compiler compilePod:pod podArchitectureOnly:NO];
    
    for (NSString *arch in [pod.architectures arrayByAddingObjectsFromArray:@[@"i386", @"x86_64"]]) {
        NSString *path = [NSString stringWithFormat:@"%@/%@_%@.a", [self.compiler.podRootDirectory stringByAppendingPathComponent:kLibsDirectory], pod.name, arch];
        XCTAssert([[NSFileManager defaultManager] fileExistsAtPath:path], @"pod arch mismatched");
    }
}

@end


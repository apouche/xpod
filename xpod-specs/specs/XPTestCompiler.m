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
#import "XPFrameworkMaker.h"

// Model
#import "XPPod.h"


@interface XPTestCompiler : XCTestCase

@property (nonatomic, strong) XPPod *pod;
@property (nonatomic, strong) XPCompiler *compiler;
@property (nonatomic, strong) XPFrameworkMaker *frameworkMaker;

- (void)compileAndLink;

@end

@implementation XPTestCompiler

- (void)setUp {
    [super setUp];
    
    self.pod = [[XPPod alloc] init];
    self.compiler = [[XPCompiler alloc] init];
    self.frameworkMaker = [[XPFrameworkMaker alloc] init];
}

- (void)tearDown {
    [super tearDown];
    
    [[NSFileManager defaultManager] removeItemAtPath:@"/tmp/xpod" error:nil];
}

- (void)compileAndLink {
    self.pod.name = @"AFNetworking";
    self.pod.architectures = @[@"armv7", @"armv7s", @"arm64"];
    
    self.compiler.podRootDirectory = @"/tmp/xpod";
    
    NSString *currentDir = [[NSFileManager defaultManager] currentDirectoryPath];
    NSString *sourceDir = [currentDir stringByAppendingPathComponent:@"xpod-specs/sources/AFNetworking"];
    [self.compiler compilePod:self.pod sourceDirectory:sourceDir podArchitectureOnly:NO];
}

- (void)testCompiler {
    [self compileAndLink];
    
    NSString *libsDirectory = [self.compiler.podRootDirectory stringByAppendingPathComponent:kLibsDirectory];
    for (NSString *arch in [self.pod.architectures arrayByAddingObjectsFromArray:@[@"i386", @"x86_64"]]) {
        NSString *libName = [NSString stringWithFormat:@"%@_%@.a", self.pod.name, arch];
        XCTAssert([[NSFileManager defaultManager] fileExistsAtPath:[libsDirectory stringByAppendingPathComponent:libName]], @"pod arch mismatched");
    }
}

- (void)testFramework {
    [self compileAndLink];
    
    NSString *libsDirectory = [self.compiler.podRootDirectory stringByAppendingPathComponent:kLibsDirectory];
    NSString *headersDirectory = [self.compiler.podRootDirectory stringByAppendingPathComponent:kHeadersDirectory];
    [self.frameworkMaker buildFrameworkAtPath:self.compiler.podRootDirectory
                                     withLibs:libsDirectory
                               sourcesHeaders:headersDirectory];
    
    XCTAssert([[NSFileManager defaultManager] fileExistsAtPath:@"/tmp/xpod/XPod.framework"], @"Framework failed");
}

@end


//
//  XPTestParsing.m
//  xpod
//
//  Created by Johan on 15/05/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

// Libs
#import <XCTest/XCTest.h>
#import "YAMLKit.h"

// Services
#import "XPTestHelper.h"
#import "XPModelParser.h"

// Model

#define kXPTestParsingBasicYAMLFile @"basic.yml"

@interface XPTestParsing : XCTestCase
@property (nonatomic, strong) XPModelParser* modelParser;

@end

@implementation XPTestParsing

- (void)setUp
{
    [super setUp];
    
    self.modelParser = [[XPModelParser alloc] init];
}

- (void)tearDown
{
    self.modelParser = nil;
    
    [super tearDown];
}

- (void)testYamlParsing
{
    NSString* basicYmlContent = [[XPTestHelper sharedHelper] fileContentWithName:kXPTestParsingBasicYAMLFile];
    id basicYamlDict = [YAMLKit loadFromString:basicYmlContent];
    
    XCTAssert(basicYmlContent, @"failed to load basic.yml file");
    XCTAssert(basicYamlDict, @"failed to parse basic.yml file");
}

- (void)testPodParsing {
    NSString* basicYmlContent = [[XPTestHelper sharedHelper] fileContentWithName:kXPTestParsingBasicYAMLFile];
    
    NSArray* basicPods = [self.modelParser podsFromYAMLString:basicYmlContent];
    
    XCTAssert(basicYmlContent, @"failed to load %@ file", kXPTestParsingBasicYAMLFile);
    XCTAssert(basicPods, @"failed to parse %@ file", kXPTestParsingBasicYAMLFile);
    XCTAssert(basicPods.count > 0, @"failed to parse pods in %@", kXPTestParsingBasicYAMLFile);
}

@end

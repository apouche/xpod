//
//  XPTestParsing.m
//  xpod
//
//  Created by Johan on 15/05/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XPTestHelper.h"
#import "YAMLKit.h"
#import "XPObject.h"

@interface XPTestParsing : XCTestCase

@end

@implementation XPTestParsing

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    XPObject* o = [[XPObject alloc] init];
    o = nil;
    NSString* basicYmlContent = [[XPTestHelper sharedHelper] fileContentWithName:@"basic.yml"];
//    NSString*
    id basicYamlDict = [YAMLKit loadFromString:basicYmlContent];
    
    XCTAssert(basicYmlContent, @"failed to load basic.yml file");
    XCTAssert(basicYamlDict, @"failed to parse basic.yml file");

}

@end

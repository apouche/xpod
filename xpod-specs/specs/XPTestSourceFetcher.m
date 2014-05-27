//
//  XPTestSourceFetcher.m
//  xpod
//
//  Created by Johan on 16/05/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

#import <XCTest/XCTest.h>

// Fetchers
#import "XPSourceFetcher.h"

// Model
#import "XPPod.h"

#define kXPTestSourcePodURL @"https://github.com/AFNetworking/AFNetworking.git"
#define kXPTestSourcePodName @"AFNetworking"

@interface XPTestSourceFetcher : XCTestCase
@property (nonatomic, strong) XPSourceFetcher* githubFetcher;

@end

@implementation XPTestSourceFetcher

- (void)setUp
{
    [super setUp];
    
    self.githubFetcher = [[XPSourceFetcher alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGithubFetcher
{
    XPPod* pod = [[XPPod alloc] init];
    pod.url = [NSURL URLWithString:kXPTestSourcePodURL];
    pod.name = kXPTestSourcePodName;
    
    
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end

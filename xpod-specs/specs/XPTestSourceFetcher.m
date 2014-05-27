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
@property (nonatomic, strong) XPSourceFetcher* sourceFetcher;
@property (nonatomic, strong) XPPod* githubPod;

@end

@implementation XPTestSourceFetcher

- (void)setUp
{
    [super setUp];
    
    self.sourceFetcher = [[XPSourceFetcher alloc] init];
    
    self.githubPod = [[XPPod alloc] init];
    self.githubPod.url = [NSURL URLWithString:kXPTestSourcePodURL];
    self.githubPod.name = kXPTestSourcePodName;
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFetcherHost
{
    XPSourceFetcherHost host = [self.sourceFetcher fetcherHostFromURL:self.githubPod.url];
    
    XCTAssert(host == XPSourceFetcherHostGithub, @"%@ should be equal to %@", @(host), @(XPSourceFetcherHostGithub));
}

@end

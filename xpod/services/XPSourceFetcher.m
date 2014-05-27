//
//  XPSourceFetcher.m
//  xpod
//
//  Created by Johan on 16/05/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

#import "XPSourceFetcher.h"

// Categories
#import "XPSourceFetcher+Github.h"
#import "NSString+RegularExpressions.h"

@interface XPSourceFetcher ()

@end

@implementation XPSourceFetcher

- (void)retreiveSourcesForPod:(XPPod *)pod completion:(void (^)(NSArray *, NSError *))completionBlock {
    
}

#pragma mark - Helpers

- (XPSourceFetcherHost)fetcherHostFromURL:(NSURL *)url {
    NSString* urlStr = [url absoluteString];
    if ([urlStr subStringWithPattern:@"github"])
        return XPSourceFetcherHostGithub;
    
    return XPSourceFetcherHostUnkown;
}

@end

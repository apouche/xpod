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

@interface XPSourceFetcher ()
- (XPSourceFetcherHost)fetcherHostFromURL:(NSURL*)url;

@end

@implementation XPSourceFetcher

- (void)retreiveSourcesForPod:(XPPod *)pod completion:(void (^)(NSArray *, NSError *))completionBlock {
    
}

#pragma mark - Helpers

- (XPSourceFetcherHost)fetcherHostFromURL:(NSURL *)url {
    return 0;
}

@end

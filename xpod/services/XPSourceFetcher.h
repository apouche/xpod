//
//  XPSourceFetcher.h
//  xpod
//
//  Created by Johan on 16/05/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XPPod;

typedef NS_ENUM(NSUInteger, XPSourceFetcherHost) {
    XPSourceFetcherHostUnkown = 0,
    XPSourceFetcherHostGithub,
};

@interface XPSourceFetcher : NSObject

- (void)retreiveSourcesForPod:(XPPod*)pod completion:(void(^)(NSArray* urls, NSError* error))completionBlock;

@end

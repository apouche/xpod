//
//  GHRepository.h
//  xpod
//
//  Created by Johan on 19/05/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

#import "GHObject.h"

@interface GHRepository : GHObject
@property (nonatomic, copy, readonly) NSString *ownerLogin;
@property (nonatomic, copy, readonly) NSString *repoDescription;
@property (nonatomic, assign, getter = isPrivate, readonly) BOOL private;
@property (nonatomic, assign, getter = isFork, readonly) BOOL fork;
@property (nonatomic, strong, readonly) NSDate *datePushed;
@property (nonatomic, copy, readonly) NSURL *httpsURL;
@property (nonatomic, copy, readonly) NSString *sshURL;
@property (nonatomic, copy, readonly) NSURL *gitURL;
@property (nonatomic, copy, readonly) NSURL *htmlURL;
@property (nonatomic, copy, readonly) NSString *defaultBranch;

@end

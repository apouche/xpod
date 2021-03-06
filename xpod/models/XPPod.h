//
//  XPPod.h
//  xpod
//
//  Created by Johan on 16/05/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

#import "XPObject.h"

extern const NSString* kXPPodURLKey;
extern const NSString* kXPPodSourceKey;
extern const NSString* kXPPodArchitecturesKey;

@interface XPPod : XPObject
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSURL* url;
@property (nonatomic, strong) NSString* sourcePattern;
@property (nonatomic, strong)NSArray *architectures;

- (id)initWithYAMLDictionary:(NSDictionary*)dictionary name:(NSString*)name;

@end

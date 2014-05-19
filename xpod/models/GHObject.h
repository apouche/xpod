//
//  GHObject.h
//  xpod
//
//  Created by Johan on 19/05/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

#import "MTLModel.h"

@interface GHObject : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *objectID;

@end

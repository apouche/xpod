//
//  XPCompiler.h
//  xpod
//
//  Created by Maxime Bokobza on 02/06/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XPPod;


extern NSString * const kLibsDirectory;
extern NSString * const kObjectFilesDirectory;


@interface XPCompiler : NSObject

@property (nonatomic, strong) NSString *podRootDirectory;

- (void)compilePod:(XPPod *)pod podArchitectureOnly:(BOOL)podArchsOnly;

@end

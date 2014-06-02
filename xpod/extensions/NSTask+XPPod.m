//
//  NSTask+XPPod.m
//  xpod
//
//  Created by Maxime Bokobza on 02/06/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

#import "NSTask+XPPod.h"

@implementation NSTask (XPPod)

+ (NSString *)launchTaskWithLaunchPath:(NSString *)launchPath arguments:(NSArray *)arguments {
    return [self launchTaskFromDirectory:nil withLaunchPath:launchPath arguments:arguments];
}

+ (NSString *)launchTaskFromDirectory:(NSString *)currentDirectory withLaunchPath:(NSString *)launchPath arguments:(NSArray *)arguments {
    NSTask *task = [[NSTask alloc] init];
    if (currentDirectory) {
        [self createDirectory:currentDirectory];
        task.currentDirectoryPath = currentDirectory;
    }
    task.launchPath = launchPath;
    task.arguments = arguments;
    
    NSPipe *output = [[NSPipe alloc] init];
    [task setStandardOutput:output];
    
    [task launch];
    [task waitUntilExit];
    
    NSData *outputData = [[output fileHandleForReading] readDataToEndOfFile];
    return [[NSString alloc] initWithData:outputData encoding:NSUTF8StringEncoding];
}

+ (NSArray *)filenamesInDirectory:(NSString *)directory ofType:(NSString *)extension {
    NSString *output = [self launchTaskWithLaunchPath:@"/bin/ls"
                                            arguments:@[directory]];
    
    NSMutableArray *filenames = [NSMutableArray array];
    for (NSString *filename in [output componentsSeparatedByString:@"\n"]) {
        if ([filename hasSuffix:[NSString stringWithFormat:@".%@", extension]])
            [filenames addObject:[directory stringByAppendingPathComponent:filename]];
    }
    
    return [NSArray arrayWithArray:filenames];
}

+ (void)createDirectory:(NSString *)directory {
    if ([[NSFileManager defaultManager] fileExistsAtPath:directory])
        return;
    
    [self launchTaskWithLaunchPath:@"/bin/mkdir"
                         arguments:@[@"-p", directory]];
}

@end

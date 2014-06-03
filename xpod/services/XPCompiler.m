//
//  XPCompiler.m
//  xpod
//
//  Created by Maxime Bokobza on 02/06/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

#import "XPCompiler.h"
#import "XPPod.h"
#import "NSTask+XPPod.h"


NSString * const kLibsDirectory = @"libs";
NSString * const kObjectFilesDirectory = @"object_files";


typedef NS_ENUM(NSUInteger, XPCompilerMode) {
    XPCompilerModeDevice,
    XPCompilerModeSimulator
};


@interface XPCompiler ()

- (void)compileForArch:(NSString *)arch withMinVersionArg:(NSString *)minVersionArg sysroot:(NSString *)sysroot sourceDir:(NSString *)sourceDir name:(NSString *)name;
- (void)linkForArch:(NSString *)arch sysroot:(NSString *)sysroot name:(NSString *)name;

- (NSString *)sdkPathForMode:(XPCompilerMode)mode;
- (NSString *)minVersionArgumentForMode:(XPCompilerMode)mode;
- (NSString *)pathToObjectFilesDirectoryForArch:(NSString *)arch name:(NSString *)name;

@end


@implementation XPCompiler

- (void)compilePod:(XPPod *)pod sourceDirectory:(NSString *)sourceDir podArchitectureOnly:(BOOL)podArchsOnly {
    NSAssert(self.podRootDirectory, @"self.podRootDirectory must not be nil");
    
    NSString *deviceMinVersionArg = [self minVersionArgumentForMode:XPCompilerModeDevice];
    NSString *deviceSDKPath = [self sdkPathForMode:XPCompilerModeDevice];
    
    for (NSString *arch in pod.architectures) {
        [self compileForArch:arch
           withMinVersionArg:deviceMinVersionArg
                     sysroot:deviceSDKPath
                   sourceDir:sourceDir
                        name:pod.name];
        
        [self linkForArch:arch
                  sysroot:deviceSDKPath
                     name:pod.name];
    }
    
    if (!podArchsOnly) {
        NSString *simulatorMinVersionArg = [self minVersionArgumentForMode:XPCompilerModeSimulator];
        NSString *simulatorSDKPath = [self sdkPathForMode:XPCompilerModeSimulator];
        
        for (NSString *arch in @[@"i386", @"x86_64"]) {
            [self compileForArch:arch
               withMinVersionArg:simulatorMinVersionArg
                         sysroot:simulatorSDKPath
                       sourceDir:sourceDir
                            name:pod.name];
            
            [self linkForArch:arch
                      sysroot:simulatorSDKPath
                         name:pod.name];
        }
    }
}

- (void)compileForArch:(NSString *)arch withMinVersionArg:(NSString *)minVersionArg sysroot:(NSString *)sysroot sourceDir:(NSString *)sourceDir name:(NSString *)name {
    NSArray *arguments = @[@"-x", @"objective-c",
                           @"-arch", arch,
                           minVersionArg,
                           @"-fmessage-length=0",
                           @"-fdiagnostics-show-note-include-stack",
                           @"-fmacro-backtrace-limit=0",
                           @"-std=gnu99",
                           @"-fobjc-arc",
                           @"-Wno-trigraphs",
                           @"-fpascal-strings",
                           @"-O0",
                           @"-isysroot", sysroot,
                           @"-c"];
    
    arguments = [arguments arrayByAddingObjectsFromArray:[NSTask filenamesInDirectory:sourceDir ofType:@"m"]];
    
    [NSTask launchTaskFromDirectory:[self pathToObjectFilesDirectoryForArch:arch name:name]
                     withLaunchPath:@"/usr/bin/clang"
                          arguments:arguments];
}

- (void)linkForArch:(NSString *)arch sysroot:(NSString *)sysroot name:(NSString *)name {
    NSArray *arguments = @[@"-static",
                           @"-arch_only", arch,
                           @"-syslibroot", sysroot,
                           @"-framework", @"Foundation"];
    
    NSString *objectFiles = [self pathToObjectFilesDirectoryForArch:arch name:name];
    NSString *libs = [self.podRootDirectory stringByAppendingPathComponent:kLibsDirectory];
    
    arguments = [arguments arrayByAddingObjectsFromArray:[NSTask filenamesInDirectory:objectFiles ofType:@"o"]];
    arguments = [arguments arrayByAddingObjectsFromArray:@[@"-o", [NSString stringWithFormat:@"%@/%@_%@.a", libs, name, arch]]];
    
    [NSTask launchTaskFromDirectory:[self.podRootDirectory stringByAppendingPathComponent:kLibsDirectory]
                     withLaunchPath:@"/usr/bin/libtool"
                          arguments:arguments];
}

- (NSString *)sdkPathForMode:(XPCompilerMode)mode {
    NSString *target = mode == XPCompilerModeDevice ? @"iphoneos" : @"iphonesimulator";
    NSString *output = [NSTask launchTaskWithLaunchPath:@"/usr/bin/xcodebuild"
                                              arguments:@[@"-sdk", target, @"-version"]];
    
    NSRange startRange = [output rangeOfString:@"Path: "];
    output = [output substringFromIndex:startRange.location + startRange.length];
    NSRange endRange = [output rangeOfString:@".sdk"];
    return [output substringToIndex:endRange.location + endRange.length];
}

- (NSString *)minVersionArgumentForMode:(XPCompilerMode)mode {
    // Fetch the right version
    NSString *version = @"7.0";
    NSString *arg = nil;
    switch (mode) {
        case XPCompilerModeDevice:
            arg = @"-miphoneos-version-min=";
            break;
            
        case XPCompilerModeSimulator:
            arg = @"-mios-simulator-version-min=";
            break;
    }
    
    return [arg stringByAppendingString:version];
}

- (NSString *)pathToObjectFilesDirectoryForArch:(NSString *)arch name:(NSString *)name {
    return [[self.podRootDirectory stringByAppendingPathComponent:kObjectFilesDirectory] stringByAppendingFormat:@"/%@_%@", name, arch];
}

@end

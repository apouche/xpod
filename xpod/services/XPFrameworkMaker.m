//
//  XPFrameworkMaker.m
//  xpod
//
//  Created by Maxime Bokobza on 06/06/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

#import "XPFrameworkMaker.h"
#import "XPCompiler.h"
#import "NSTask+XPPod.h"


static NSString * const kFrameworkName = @"XPod";


@interface XPFrameworkMaker ()

@property (nonatomic, strong) NSString *frameworkRootPath;

- (void)copyHeadersFromPath:(NSString *)headers;
- (void)buildGlobalHeader;
- (void)wrapLibrariesInDirectory:(NSString *)libs;
- (void)buildSymlinks;

- (NSString *)pathToFramework;
- (NSString *)pathToVersion;
- (NSString *)pathToHeaders;

@end


@implementation XPFrameworkMaker

- (void)buildFrameworkAtPath:(NSString *)path withLibs:(NSString *)libs sourcesHeaders:(NSString *)headers {
    self.frameworkRootPath = path;
    
    [self copyHeadersFromPath:headers];
    [self buildGlobalHeader];
    [self wrapLibrariesInDirectory:libs];
    [self buildSymlinks];
}

- (void)copyHeadersFromPath:(NSString *)headers {
    [NSTask copyFiles:[NSTask filesPathInDirectory:headers ofType:@"h"]
          toDirectory:[self pathToHeaders]];
}

- (void)buildGlobalHeader {
    NSMutableString *headerText = [NSMutableString string];
    for (NSString *h in [NSTask filesPathInDirectory:[self pathToHeaders] ofType:@"h"]) {
        [headerText appendFormat:@"#import <%@/%@>\n", kFrameworkName, [h lastPathComponent]];
    }
    
    [headerText writeToFile:[[self pathToHeaders] stringByAppendingFormat:@"/%@.h", kFrameworkName]
                 atomically:YES
                   encoding:NSUTF8StringEncoding
                      error:nil];
}

- (void)wrapLibrariesInDirectory:(NSString *)libs {
    NSArray *arguments = @[@"-output", [kFrameworkName lowercaseString], @"-create"];
    arguments = [arguments arrayByAddingObjectsFromArray:[NSTask filesPathInDirectory:libs ofType:@"a"]];
    
    [NSTask launchTaskFromDirectory:[self pathToVersion]
                     withLaunchPath:@"/usr/bin/lipo"
                          arguments:arguments];
}

- (void)buildSymlinks {
    [NSTask symlinkInDirectory:[[self pathToFramework] stringByAppendingPathComponent:@"Versions"]
                      fromFile:@"A"
                        toFile:@"Current"];
    
    [NSTask symlinkInDirectory:[self pathToFramework]
                      fromFile:[NSString stringWithFormat:@"Versions/Current/%@", [kFrameworkName lowercaseString]]
                        toFile:@"./"];
    
    [NSTask symlinkInDirectory:[self pathToFramework]
                      fromFile:@"Versions/Current/Headers"
                        toFile:@"./"];
}

- (NSString *)pathToFramework {
    return [[self.frameworkRootPath stringByAppendingPathComponent:kFrameworkName] stringByAppendingPathExtension:@"framework"];
}

- (NSString *)pathToVersion {
    NSString *frameworkPath = [self pathToFramework];
    return [frameworkPath stringByAppendingPathComponent:@"Versions/A"];
}

- (NSString *)pathToHeaders {
    return [[self pathToVersion] stringByAppendingPathComponent:@"Headers"];
}

@end

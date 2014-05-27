//
//  NSString+RegularExpressions.h
//  celeste
//
//  Created by Johan on 5/23/14.
//  Copyright (c) 2014 Martico. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RegularExpressions)

#pragma mark Matches
- (NSArray *)expressionsMatchingPattern:(NSString *)pattern;
- (NSArray *)expressionsMatchingPattern:(NSString *)pattern options:(NSRegularExpressionOptions)options;

#pragma mark Substrings
- (NSString *)subStringWithPattern:(NSString *)pattern;
- (NSString *)subStringWithPattern:(NSString *)pattern options:(NSRegularExpressionOptions)options;

#pragma mark Ranges
- (NSRange)rangeOfPattern:(NSString *)pattern options:(NSRegularExpressionOptions)options;
- (NSArray*)rangesOfString:(NSString*)string ;
- (NSArray*)rangesOfString:(NSString*)string options:(NSStringCompareOptions)mask;
- (NSArray*)rangesOfString:(NSString*)string options:(NSStringCompareOptions)mask range:(NSRange)searchRange;


@end

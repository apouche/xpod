//
//  NSString+RegularExpressions.m
//  celeste
//
//  Created by Johan on 5/23/14.
//  Copyright (c) 2014 Martico. All rights reserved.
//

#import "NSString+RegularExpressions.h"

@implementation NSString (RegularExpressions)

#pragma mark - Matches

- (NSArray *)expressionsMatchingPattern:(NSString *)pattern {
	return [self expressionsMatchingPattern:pattern options:NSRegularExpressionCaseInsensitive];
}

- (NSArray *)expressionsMatchingPattern:(NSString *)pattern options:(NSRegularExpressionOptions)options {
    
	NSRegularExpression* regexp = [NSRegularExpression regularExpressionWithPattern:pattern
																			options:options
																			  error:NULL];
    
	NSArray* matches = [regexp matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
	return matches.count ? matches : nil;
}

#pragma mark - Substrings

- (NSString *)subStringWithPattern:(NSString *)pattern {
	return [self subStringWithPattern:pattern options:NSRegularExpressionCaseInsensitive];
}

- (NSString *)subStringWithPattern:(NSString *)pattern options:(NSRegularExpressionOptions)options {
	NSRange range = [self rangeOfPattern:pattern options:options];
    
	if (range.location != NSNotFound) {
		return [self substringWithRange:range];
	}
	return [self copy];
}

#pragma mark - Ranges

- (NSRange)rangeOfPattern:(NSString *)pattern options:(NSRegularExpressionOptions)options {
	NSRegularExpression* regexp = [NSRegularExpression regularExpressionWithPattern:pattern
																			options:options
																			  error:NULL];
    
	return [regexp rangeOfFirstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    
}

- (NSArray*)rangesOfString:(NSString*)string {
	return [self rangesOfString:string options:0];
}

- (NSArray*)rangesOfString:(NSString*)string options:(NSStringCompareOptions)mask {
	return [self rangesOfString:string options:mask range:NSMakeRange(0, self.length)];
}

- (NSArray*)rangesOfString:(NSString*)string options:(NSStringCompareOptions)mask range:(NSRange)searchRange {
	NSMutableArray* ranges = [NSMutableArray array];
    
	NSUInteger maxLocation = searchRange.location + searchRange.length;
	NSRange currentSearchRange = searchRange;
    
	while (currentSearchRange.location < maxLocation) {
		NSRange foundRange = [self rangeOfString:string options:mask range:currentSearchRange];
		if (foundRange.location != NSNotFound) {
			// Found an occurrence of the string
			[ranges addObject:[NSValue valueWithRange:foundRange]];
			currentSearchRange.location = foundRange.location + foundRange.length;
			currentSearchRange.length = maxLocation > currentSearchRange.location ?
            maxLocation - currentSearchRange.location : maxLocation;
		} else {
			// No more string to find
			break;
		}
	}
    
	return ranges.count ? ranges : nil;
}

@end

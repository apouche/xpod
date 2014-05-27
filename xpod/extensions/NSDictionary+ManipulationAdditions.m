//
//  NSDictionary+ManipulationAdditions.m
//  celeste
//
//  Created by Johan on 5/20/14.
//  Copyright (c) 2014 Martico. All rights reserved.
//

#import "NSDictionary+ManipulationAdditions.h"

@implementation NSDictionary (ManipulationAdditions)

- (NSDictionary *)dictionaryByAddingEntriesFromDictionary:(NSDictionary *)dictionary {
	NSMutableDictionary *result = [self mutableCopy];
	[result addEntriesFromDictionary:dictionary];
	return result;
}

- (NSDictionary *)dictionaryByRemovingEntriesWithKeys:(NSSet *)keys {
	NSMutableDictionary *result = [self mutableCopy];
	[result removeObjectsForKeys:keys.allObjects];
	return result;
}

@end

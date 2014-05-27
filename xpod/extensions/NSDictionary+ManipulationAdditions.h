//
//  NSDictionary+ManipulationAdditions.h
//  celeste
//
//  Created by Johan on 5/20/14.
//  Copyright (c) 2014 Martico. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ManipulationAdditions)

- (NSDictionary *)dictionaryByAddingEntriesFromDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)dictionaryByRemovingEntriesWithKeys:(NSSet *)keys;

@end

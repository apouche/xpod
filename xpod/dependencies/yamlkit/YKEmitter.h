//
//  YKEncoder.h
//  YAMLKit
//
//  Created by Patrick Thomson on 12/29/08.
//

#import <Foundation/Foundation.h>
#import "yaml.h"

@interface YKEmitter : NSObject {
    yaml_emitter_t emitter;
    NSMutableData *buffer;
}

- (void)emitItem:(id)item;
- (NSString *)emittedString;
- (NSData *)emittedData;

@property(nonatomic, assign) BOOL usesExplicitDelimiters;
@property(nonatomic, assign) NSStringEncoding encoding;


@end

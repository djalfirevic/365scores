//
//  BaseObject.m
//  Scores365
//
//  Created by Djuro Alfirevic on 6/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "BaseObject.h"

@implementation BaseObject

#pragma mark - Designated Initializer

- (instancetype)initFromDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.ID = [JSONNullChecker parseINT:[dictionary objectForKey:@"ID"]];
        self.name = [JSONNullChecker parseSTRING:[dictionary objectForKey:@"Name"]];
    }
    
    return self;
}

#pragma mark - Public API

- (NSString *)cellIdentifier {
    return EMPTY_STRING;
}

- (void)logData {
    NSLog(@"%@", self.name);
}

- (void)updateFromObject:(BaseObject *)object {
    
}

- (BOOL)isEqual:(id)object {
    BaseObject *comparingObject = (BaseObject *)object;
    
    if (comparingObject.ID == self.ID) {
        return YES;
    }
    
    return NO;
}

@end
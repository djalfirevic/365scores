//
//  BaseObject.h
//  Scores365
//
//  Created by Djuro Alfirevic on 6/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseObject : NSObject
@property (nonatomic) NSInteger ID;
@property (copy, nonatomic) NSString *name;

- (instancetype)initFromDictionary:(NSDictionary *)dictionary;
- (NSString *)imageURL;
- (void)logData;
- (void)updateFromObject:(BaseObject *)object;
@end
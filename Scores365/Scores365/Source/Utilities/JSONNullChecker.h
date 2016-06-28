//
//  JSONNullChecker.h
//  Scores365
//
//  Created by Djuro Alfirevic on 6/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONNullChecker : NSObject
+ (NSString *)parseSTRING:(id)object;
+ (BOOL)parseBOOL:(id)object;
+ (int)parseINT:(id)object;
+ (long long)parseLONG:(id)object;
+ (float)parseFLOAT:(id)object;
@end
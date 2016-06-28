//
//  NSObject+Utilities.m
//  Scores365
//
//  Created by Djuro Alfirevic on 6/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "NSObject+Utilities.h"
#import "Reachability.h"

@implementation NSObject (Utilities)

#pragma mark - Public API

- (BOOL)hasInternetConnection {
    Reachability *reach	= [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reach currentReachabilityStatus];
    
    if (status == NotReachable) {
        return NO;
    }
    
    return YES;
}

@end
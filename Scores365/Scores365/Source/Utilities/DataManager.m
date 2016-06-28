//
//  DataManager.m
//  Scores365
//
//  Created by Djuro Alfirevic on 6/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

#pragma mark - Properties

- (NSMutableArray *)countriesArray {
    if (!_countriesArray) {
        _countriesArray = [[NSMutableArray alloc] init];
    }
    
    return _countriesArray;
}

#pragma mark - Singleton

+ (DataManager *)sharedInstance {
    static DataManager *sharedManager;
    
    @synchronized(self)	{
        if (sharedManager == nil) {
            sharedManager = [[DataManager alloc] init];
        }
    }
    
    return sharedManager;
}

@end
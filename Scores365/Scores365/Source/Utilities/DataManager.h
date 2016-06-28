//
//  DataManager.h
//  Scores365
//
//  Created by Djuro Alfirevic on 6/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject
+ (id)sharedInstance;
- (void)prepareDataWithCompletion:(void (^)(NSMutableArray *itemsArray))handler;
@end
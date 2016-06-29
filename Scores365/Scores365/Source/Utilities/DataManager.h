//
//  DataManager.h
//  Scores365
//
//  Created by Djuro Alfirevic on 6/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataManagerDelegate <NSObject>
@optional
- (void)dataUpdatedAtIndex:(NSInteger)index;
@end

@interface DataManager : NSObject
@property (weak, nonatomic) id<DataManagerDelegate> delegate;
+ (id)sharedInstance;
- (void)prepareDataWithCompletion:(void (^)(NSMutableArray *itemsArray))handler;
@end
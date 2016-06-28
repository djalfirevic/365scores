//
//  Game.h
//  Scores365
//
//  Created by Djuro Alfirevic on 6/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "BaseObject.h"

@interface Game : BaseObject
@property (nonatomic) NSInteger comp;
@property (nonatomic, getter=isActive) BOOL active;
@property (nonatomic) NSInteger gameTime;
@property (nonatomic) NSString *startTimeString;
@property (nonatomic) NSDate *startTime;
@property (nonatomic) NSArray *scoresArray;
@property (nonatomic) NSMutableArray *competitorsArray;

- (NSString *)score;
@end
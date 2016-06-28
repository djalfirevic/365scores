//
//  Game.m
//  Scores365
//
//  Created by Djuro Alfirevic on 6/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "Game.h"
#import "Competitor.h"

@implementation Game

#pragma mark - Properties

- (NSMutableArray *)competitorsArray {
    if (!_competitorsArray) {
        _competitorsArray = [[NSMutableArray alloc] init];
    }
    
    return _competitorsArray;
}

#pragma mark - Designated Initializer

- (instancetype)initFromDictionary:(NSDictionary *)dictionary {
    if (self = [super initFromDictionary:dictionary]) {
        self.comp = [JSONNullChecker parseINT:[dictionary objectForKey:@"Comp"]];
        self.active = [JSONNullChecker parseBOOL:[dictionary objectForKey:@"Active"]];
        self.gameTime = [JSONNullChecker parseINT:[dictionary objectForKey:@"GT"]];
        self.startTimeString = [JSONNullChecker parseSTRING:[dictionary objectForKey:@"STime"]];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"MM-dd-yyyy HH:mm";
        self.startTime = [dateFormatter dateFromString:self.startTimeString];
        
        self.scoresArray = [dictionary objectForKey:@"Scrs"];
        
        if ([dictionary objectForKey:@"Comps"]) {
            for (NSDictionary *competitorDictionary in dictionary[@"Comps"]) {
                [self.competitorsArray addObject:[[Competitor alloc] initFromDictionary:competitorDictionary]];
            }
        }
    }
    
    return self;
}

#pragma mark - Public API

- (NSString *)humanReadableStartTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd/MM HH:mm";
    
    return [dateFormatter stringFromDate:self.startTime];
}

@end
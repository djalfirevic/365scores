//
//  DataManager.m
//  Scores365
//
//  Created by Djuro Alfirevic on 6/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "DataManager.h"
#import "WebServiceManager.h"
#import "Competition.h"
#import "Country.h"
#import "Game.h"

#define kTimerTick 5.0

@interface DataManager()
@property (strong, nonatomic) NSMutableArray *countriesArray;
@property (strong, nonatomic) NSMutableArray *gamesArray;
@property (strong, nonatomic) NSMutableArray *competitionsArray;
@property (strong, nonatomic) NSMutableArray *resultsArray;
@property (strong, nonatomic) NSTimer *updateTimer;
@property (nonatomic) NSInteger lastUpdateID;
@end

@implementation DataManager

#pragma mark - Properties

- (NSMutableArray *)countriesArray {
    if (!_countriesArray) {
        _countriesArray = [[NSMutableArray alloc] init];
    }
    
    return _countriesArray;
}

- (NSMutableArray *)gamesArray {
    if (!_gamesArray) {
        _gamesArray = [[NSMutableArray alloc] init];
    }
    
    return _gamesArray;
}

- (NSMutableArray *)competitionsArray {
    if (!_competitionsArray) {
        _competitionsArray = [[NSMutableArray alloc] init];
    }
    
    return _competitionsArray;
}

- (NSMutableArray *)resultsArray {
    if (!_resultsArray) {
        _resultsArray = [[NSMutableArray alloc] init];
    }
    
    return _resultsArray;
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

#pragma mark - Public API

- (void)prepareDataWithCompletion:(void (^)(NSMutableArray *itemsArray))handler {
    [[WebServiceManager sharedInstance] requestDataFromURL:[NSString stringWithFormat:@"%@%@", MAIN_URL, GAMES_URL]
                                                withLoader:YES
                                            withCompletion:^(BOOL success, NSDictionary *dictionary, NSError *error)
     {
         if (success) {
             [self parseDataFromDictionary:dictionary withCompletion:^{
                 [self prepareResults];
                 
                 handler(self.resultsArray);
                 
                 // Initialize timer
                 self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:kTimerTick
                                                                     target:self
                                                                   selector:@selector(updateData)
                                                                   userInfo:nil
                                                                    repeats:YES];
             }];
         } else {
             handler(nil);
         }
     }];
}

- (NSString *)getCountryNameCountryID:(NSInteger)countryID {
    for (Country *country in self.countriesArray) {
        if (country.ID == countryID) {
            return country.name;
        }
    }
    
    return nil;
}

#pragma mark - Private API

- (void)mergeObject:(BaseObject *)object {
    
    // Games
    if ([object isKindOfClass:[Game class]]) {
        Game *game = (Game *)object;
        
        NSInteger index = [self gameAlreadyExists:game.ID];
        if (index != INT_MAX) {
            if ([self.delegate respondsToSelector:@selector(dataUpdatedAtIndex:)]) {
                [self.delegate dataUpdatedAtIndex:index];
            }
        }
    }
    
    // Competitions
    if ([object isKindOfClass:[Competition class]]) {
        Competition *competition = (Competition *)object;
        
        NSInteger index = [self competitionAlreadyExists:competition.ID];
        if (index != INT_MAX) {
            if ([self.delegate respondsToSelector:@selector(dataUpdatedAtIndex:)]) {
                [self.delegate dataUpdatedAtIndex:index];
            }
        }
    }
    
}

- (NSMutableArray *)getGamesByCompetitionID:(NSInteger)competitionID {
    NSMutableArray *gamesArray = [[NSMutableArray alloc] init];
    
    for (Game *game in self.gamesArray) {
        if (game.comp == competitionID) {
            [gamesArray addObject:game];
        }
    }
    
    return gamesArray;
}

- (void)updateData {
    [[WebServiceManager sharedInstance] requestDataFromURL:[NSString stringWithFormat:@"%@%@&UID=%ld", MAIN_URL, GAMES_URL, self.lastUpdateID]
                                                withLoader:YES
                                            withCompletion:^(BOOL success, NSDictionary *dictionary, NSError *error)
     {
         if (success) {
             NSLog(@"Update: %@", dictionary);
             
             self.lastUpdateID = [JSONNullChecker parseINT:dictionary[@"LastUpdateID"]];
             NSMutableArray *resultsArray = [NSMutableArray array];
             
             // Parse countries
             for (NSDictionary *countryDictionary in dictionary[@"Countries"]) {
                 Country *country = [[Country alloc] initFromDictionary:countryDictionary];
                 [self.countriesArray addObject:country];
                 [resultsArray addObject:country];
             }
             
             // Parse games
             for (NSDictionary *gameDictionary in dictionary[@"Games"]) {
                 Game *game = [[Game alloc] initFromDictionary:gameDictionary];
                 [self.gamesArray addObject:game];
                 [resultsArray addObject:game];
             }
             
             // Parse competitions
             for (NSDictionary *competitionDictionary in dictionary[@"Competitions"]) {
                 Competition *competition = [[Competition alloc] initFromDictionary:competitionDictionary];
                 competition.gamesArray = [self getGamesByCompetitionID:competition.ID];
                 [self.competitionsArray addObject:competition];
                 [resultsArray addObject:competition];
             }
             
             for (BaseObject *object in resultsArray) {
                 [self mergeObject:object];
             }
         }
     }];
}

- (void)parseDataFromDictionary:(NSDictionary *)dictionary withCompletion:(void (^)(void))handler {
    NSLog(@"%@", dictionary);
    
    self.lastUpdateID = [JSONNullChecker parseINT:dictionary[@"LastUpdateID"]];
    
    // Parse countries
    for (NSDictionary *countryDictionary in dictionary[@"Countries"]) {
        Country *country = [[Country alloc] initFromDictionary:countryDictionary];
        [self.countriesArray addObject:country];
    }
    
    // Parse games
    for (NSDictionary *gameDictionary in dictionary[@"Games"]) {
        Game *game = [[Game alloc] initFromDictionary:gameDictionary];
        [self.gamesArray addObject:game];
    }
    
    // Parse competitions
    for (NSDictionary *competitionDictionary in dictionary[@"Competitions"]) {
        Competition *competition = [[Competition alloc] initFromDictionary:competitionDictionary];
        competition.gamesArray = [self getGamesByCompetitionID:competition.ID];
        [self.competitionsArray addObject:competition];
    }
    
    handler();
}

- (void)prepareResults {
    for (Competition *competition in self.competitionsArray) {
        [self.resultsArray addObject:competition];
        [self.resultsArray addObjectsFromArray:competition.gamesArray];
    }
}

- (NSInteger)gameAlreadyExists:(NSInteger)gameID {
    for (NSInteger i = 0; i < self.resultsArray.count; i++) {
        BaseObject *object = [self.resultsArray objectAtIndex:i];
        
        if ([object isKindOfClass:[Game class]]) {
            Game *game = (Game *)object;
            
            if (game.ID == gameID) {
                return i;
            }
        }
    }
    
    return INT_MAX;
}

- (NSInteger)competitionAlreadyExists:(NSInteger)competitionID {
    for (NSInteger i = 0; i < self.resultsArray.count; i++) {
        BaseObject *object = [self.resultsArray objectAtIndex:i];
        
        if ([object isKindOfClass:[Competition class]]) {
            Competition *competition = (Competition *)object;
            
            if (competition.ID == competitionID) {
                return i;
            }
        }
    }
    
    return INT_MAX;
}

@end
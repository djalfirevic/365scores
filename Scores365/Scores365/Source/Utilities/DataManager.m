//
//  DataManager.m
//  Scores365
//
//  Created by Djuro Alfirevic on 6/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "DataManager.h"
#import "Competition.h"
#import "Country.h"
#import "Game.h"

@interface DataManager()
@property (strong, nonatomic) NSMutableArray *countriesArray;
@property (strong, nonatomic) NSMutableArray *gamesArray;
@property (strong, nonatomic) NSMutableArray *competitionsArray;
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

#pragma mark - Private API

- (NSMutableArray *)getGamesByCompetitionID:(NSInteger)competitionID {
    NSMutableArray *gamesArray = [[NSMutableArray alloc] init];
    
    for (Game *game in self.gamesArray) {
        if (game.comp == competitionID) {
            [gamesArray addObject:game];
        }
    }
    
    return gamesArray;
}

- (NSString *)getCountryNameCountryID:(NSInteger)countryID {
    for (Country *country in self.countriesArray) {
        if (country.ID == countryID) {
            return country.name;
        }
    }
    
    return nil;
}

#pragma mark - Public API

- (void)prepareData:(NSDictionary *)dictionary completion:(void (^)(NSMutableArray *itemsArray))handler {
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
    
    // Prepare results
    NSMutableArray *resultsArray = [[NSMutableArray alloc] init];
    
    for (Competition *competition in self.competitionsArray) {
        [resultsArray addObject:competition];
        [resultsArray addObjectsFromArray:competition.gamesArray];
    }
    
    handler(resultsArray);
}

@end
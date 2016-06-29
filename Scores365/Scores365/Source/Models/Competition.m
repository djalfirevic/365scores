//
//  Competition.m
//  Scores365
//
//  Created by Djuro Alfirevic on 6/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "Competition.h"
#import "DataManager.h"

@implementation Competition

#pragma mark - Properties

- (NSMutableArray *)gamesArray {
    if (!_gamesArray) {
        _gamesArray = [[NSMutableArray alloc] init];
    }
    
    return _gamesArray;
}

#pragma mark - Designated Initializer

- (instancetype)initFromDictionary:(NSDictionary *)dictionary {
    if (self = [super initFromDictionary:dictionary]) {
        self.countryID = [JSONNullChecker parseINT:[dictionary objectForKey:@"CID"]];
    }
    
    return self;
}

#pragma mark - Public API

- (NSString *)imageURL {
    NSString *url = [NSString stringWithFormat:@"%@image/upload/w_140,h_140,c_limit,f_webp,q_90,d_Countries:Round:default.png/Countries/Round/%ld",
                     IMAGE_CACHE_URL,
                     (long)self.countryID];
    
    return url;
}

- (NSString *)getNameWithCountry {
    return [NSString stringWithFormat:@"%@ - %@",
            [[DataManager sharedInstance] getCountryNameCountryID:self.countryID],
            self.name];
}

@end
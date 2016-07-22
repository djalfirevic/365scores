//
//  Competition.h
//  Scores365
//
//  Created by Djuro Alfirevic on 6/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "BaseObject.h"
#import "ImageProtocol.h"

@interface Competition : BaseObject <ImageProtocol>
@property (nonatomic) NSInteger countryID;
@property (strong, nonatomic) NSMutableArray *gamesArray;

- (NSString *)getNameWithCountry;
@end
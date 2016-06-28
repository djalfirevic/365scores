//
//  BaseTableViewCell.m
//  Scores365
//
//  Created by Djuro Alfirevic on 6/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "Game.h"
#import "Competition.h"

@implementation BaseTableViewCell

#pragma mark - Properties

- (void)setBaseObject:(BaseObject *)baseObject {
    _baseObject = baseObject;
}

#pragma mark - Public API

+ (NSString *)getReusableIdentifier:(Class)objectClass {
    if (objectClass == [Game class]) {
        return @"GameCell";
    } else if (objectClass == [Competition class]) {
        return @"CompetitionCell";
    }
    
    return EMPTY_STRING;
}

#pragma mark - Cell lifecycle

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.asyncImageView.image = nil;
}

@end
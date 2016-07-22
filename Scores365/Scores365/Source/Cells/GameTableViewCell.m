//
//  GameTableViewCell.m
//  Scores365
//
//  Created by Djuro Alfirevic on 6/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "GameTableViewCell.h"
#import "Game.h"
#import "Competitor.h"

@implementation GameTableViewCell

#pragma mark - Properties

- (void)setBaseObject:(BaseObject *)baseObject {
    [super setBaseObject:baseObject];
    
    if ([baseObject isKindOfClass:[Game class]]) {
        Game *game = (Game *)baseObject;
        
        if (game.competitorsArray.count == 2) {
            // Home
            Competitor *home = [game.competitorsArray firstObject];
            
            if ([home conformsToProtocol:@protocol(ImageProtocol)]) {
                self.asyncImageView.imageURL = [home imageURL];
            }
            
            self.titleLabel.text = home.name;
            
            // Away
            Competitor *away = [game.competitorsArray lastObject];
            
            if ([away conformsToProtocol:@protocol(ImageProtocol)]) {
                self.awayAsyncImageView.imageURL = [away imageURL];
            }
            
            self.awayTitleLabel.text = away.name;
            
            // Score
            self.scoreLabel.text = [game score];
            
            // Ended
            self.endedLabel.hidden = ![game hasEnded];
        }
    }
}

#pragma mark - Cell lifecycle

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.awayAsyncImageView.image = nil;
}

@end
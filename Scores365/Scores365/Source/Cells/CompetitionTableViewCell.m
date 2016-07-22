//
//  CompetitionTableViewCell.m
//  Scores365
//
//  Created by Djuro Alfirevic on 6/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "CompetitionTableViewCell.h"
#import "Competition.h"

@implementation CompetitionTableViewCell

#pragma mark - Properties

- (void)setBaseObject:(BaseObject *)baseObject {
    [super setBaseObject:baseObject];
    
    if ([baseObject isKindOfClass:[Competition class]]) {
        Competition *competition = (Competition *)baseObject;
    
        if ([competition conformsToProtocol:@protocol(ImageProtocol)]) {
            self.asyncImageView.imageURL = [competition imageURL];
        }
        
        self.titleLabel.text = [competition getNameWithCountry];
    }
}

@end
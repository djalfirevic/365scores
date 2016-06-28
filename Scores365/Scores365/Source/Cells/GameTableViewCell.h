//
//  GameTableViewCell.h
//  Scores365
//
//  Created by Djuro Alfirevic on 6/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface GameTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet AsyncImageView *awayAsyncImageView;
@property (weak, nonatomic) IBOutlet UILabel *awayTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *endedLabel;
@end
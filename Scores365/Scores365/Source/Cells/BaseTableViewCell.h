//
//  BaseTableViewCell.h
//  Scores365
//
//  Created by Djuro Alfirevic on 6/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "BaseObject.h"

@interface BaseTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet AsyncImageView *asyncImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) BaseObject *baseObject;
@end
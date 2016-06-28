//
//  AsyncImageView.m
//  Scores365
//
//  Created by Djuro Alfirevic on 6/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "AsyncImageView.h"
#import "Reachability.h"

@implementation AsyncImageView

#pragma mark - Properties

- (void)setImageURL:(NSString *)imageURL {
    _imageURL = imageURL;
    
    if ([self hasInternetConnection]) {
        dispatch_queue_t downloadQueue = dispatch_queue_create("AsyncImageViewDownloader", NULL);
        dispatch_async(downloadQueue, ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = [UIImage imageWithData:data];
            });
        });
    }
}

@end
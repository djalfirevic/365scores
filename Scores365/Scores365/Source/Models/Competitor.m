//
//  Competitor.m
//  Scores365
//
//  Created by Djuro Alfirevic on 6/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "Competitor.h"

@implementation Competitor

#pragma mark - ImageProtocol

- (NSString *)imageURL {
    NSString *url = [NSString stringWithFormat:@"%@image/upload/w_48,h_48,c_limit,f_webp,q_90,d_Competitors:default1.png/Competitors/%ld",
                     IMAGE_CACHE_URL,
                     (long)self.ID];
    
    return url;
}

@end